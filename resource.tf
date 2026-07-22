resource "aws_ebs_volume" "mergemasterops_IAC" {
  availability_zone = var.availablity_zone
  size              = var.volume_size
  tags = {
    Name = "mergemasterops_IAC_ebs"
  }

}
resource "aws_s3_bucket" "mergemasterops_IAC_bucket" {
  bucket = "mergemasterops-iac-bucket"
  tags = {
    Name = "mergemasterops_IAC_bucket"
  }

}
resource "aws_security_group" "mergemasterops_IAC_SG" {
  name        = "mergemaster-web-security"
  description = "allow inbound traffic for Kubernetes cluster"
  vpc_id      = var.VPC_ID

  tags = {
    name = "web_security"
  }

  ingress {
    description = "allow ssh from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow http from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow https from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# Kubernetes inter-node communication rules
resource "aws_security_group_rule" "k8s_api_server" {
  type              = "ingress"
  from_port         = 6443
  to_port           = 6443
  protocol          = "tcp"
  security_group_id = aws_security_group.mergemasterops_IAC_SG.id
  source_security_group_id = aws_security_group.mergemasterops_IAC_SG.id
  description       = "Kubernetes API server communication between nodes"
}

resource "aws_security_group_rule" "kubelet_api" {
  type              = "ingress"
  from_port         = 10250
  to_port           = 10260
  protocol          = "tcp"
  security_group_id = aws_security_group.mergemasterops_IAC_SG.id
  source_security_group_id = aws_security_group.mergemasterops_IAC_SG.id
  description       = "Kubelet API communication between nodes"
}

resource "aws_security_group_rule" "etcd" {
  type              = "ingress"
  from_port         = 2379
  to_port           = 2380
  protocol          = "tcp"
  security_group_id = aws_security_group.mergemasterops_IAC_SG.id
  source_security_group_id = aws_security_group.mergemasterops_IAC_SG.id
  description       = "etcd communication on master node"
}

resource "aws_security_group_rule" "pod_network_tcp" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  security_group_id = aws_security_group.mergemasterops_IAC_SG.id
  source_security_group_id = aws_security_group.mergemasterops_IAC_SG.id
  description       = "Pod network communication (Calico) - TCP"
}

resource "aws_security_group_rule" "pod_network_udp" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "udp"
  security_group_id = aws_security_group.mergemasterops_IAC_SG.id
  source_security_group_id = aws_security_group.mergemasterops_IAC_SG.id
  description       = "Pod network communication (Calico) - UDP"
}

resource "aws_instance" "C1-CP1" {
  ami                    = var.AMI
  instance_type          = var.instance_type
  region                 = var.region
  vpc_security_group_ids = [aws_security_group.mergemasterops_IAC_SG.id]
  key_name               = var.akumar
  root_block_device {
    volume_size           = 10
    volume_type           = "gp2"
    delete_on_termination = true
  }
  tags = {
    Name = "C1-CP1"
  }




}

resource "aws_instance" "C1-node1" {
  ami                    = var.AMI
  instance_type          = var.instance_type
  region                 = var.region
  key_name               = var.akumar
  vpc_security_group_ids = [aws_security_group.mergemasterops_IAC_SG.id]
  root_block_device {
    volume_size           = 10
    volume_type           = "gp2"
    delete_on_termination = true
  }
  tags = {
    Name = "C1-node1"
  }



}
resource "aws_instance" "C1-node2" {
  ami           = var.AMI
  instance_type = var.instance_type
  region        = var.region
  key_name      = var.akumar
  root_block_device {
    volume_size           = 10
    volume_type           = "gp2"
    delete_on_termination = true
  }
  vpc_security_group_ids = [aws_security_group.mergemasterops_IAC_SG.id]
  tags = {
    Name = "C1-node2"
  }



}

