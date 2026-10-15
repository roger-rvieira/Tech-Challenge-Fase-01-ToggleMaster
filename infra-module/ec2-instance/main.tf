data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = file(pathexpand(var.public_key_path))

  tags = {
    Name = var.key_name
  }
}

resource "aws_kms_key" "ssh_private_key" {
  description             = "Criptografia da chave privada SSH para ${var.name}"
  deletion_window_in_days = 30
  enable_key_rotation     = true

  tags = {
    Name = "${var.name}-ssh-private-key"
  }
}

resource "aws_kms_alias" "ssh_private_key" {
  name          = "alias/${var.name}-ssh-private-key"
  target_key_id = aws_kms_key.ssh_private_key.key_id
}

resource "aws_iam_role" "ec2_secrets_role" {
  name = "${var.name}-ec2-secrets-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "${var.name}-ec2-secrets-role"
  }
}

resource "aws_iam_role_policy" "ec2_secrets_policy" {
  name = "${var.name}-ec2-rds-secret-read"
  role = aws_iam_role.ec2_secrets_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ReadRdsCredentialsSecret"
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = var.db_secret_arn
      }
    ]
  })
}

resource "aws_iam_instance_profile" "this" {
  name = "${var.name}-ec2-profile"
  role = aws_iam_role.ec2_secrets_role.name

  tags = {
    Name = "${var.name}-ec2-profile"
  }
}

resource "aws_instance" "this" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = aws_key_pair.this.key_name
  iam_instance_profile        = aws_iam_instance_profile.this.name
  associate_public_ip_address = true
  user_data = templatefile("${path.module}/user_data.sh.tftpl", {
    aws_region     = var.aws_region
    db_secret_name = var.db_secret_name
    app_repo_url   = var.app_repo_url
  })
  user_data_replace_on_change = true

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {
    encrypted   = true
    volume_size = 10
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.name}-ec2"
  }
}