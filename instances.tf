# Data block for the ami of instances
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20230328"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

# Data block for availabilty zone
data "aws_availability_zones" "az" {
  state = "available"
}

# Data block for the ID of public subnet
data "aws_subnet" "public_1" {
  filter {
    name   = "tag:Name"
    values = ["Live-Self Managed k8s-public-subnet-1"]
  }
}

# Data block for getting the Security group
data "aws_security_group" "master_node_sg" {
  filter {
    name   = "tag:Name"
    values = ["Live-Self Managed k8s-Worker-Node-SG"]
  }
}

# Data block to get the key pair
data "aws_key_pair" "k8s_keypair" {
  filter {
    name   = "tag:Name"
    values = ["Live-Self Managed k8s-key-pair"]
  }
}

# Resource block for the AWS EC2 Instance.
resource "aws_instance" "code_delpoy_instance" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.ec2_instance_type
  key_name               = data.aws_key_pair.k8s_keypair.key_name
  availability_zone      = data.aws_availability_zones.az.names[0]
  subnet_id              = data.aws_subnet.public_1.id
  vpc_security_group_ids = [data.aws_security_group.master_node_sg.id]

  root_block_device {
    volume_size = 8
    volume_type = "gp2"
    tags = {
      "Name" = "CodeDeploy-Instance-Volume"
      "Size" = "10"
    }
  }
  tags = {
    "Name" = "${local.name_suffix}-instance"
    "AZ"   = "${data.aws_availability_zones.az.names[0]}"
  }
}
