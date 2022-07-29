packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "learn-packer-linux-aws6"
  instance_type = "t3.medium"
  region        = "ap-northeast-3"
  vpc_id        = "vpc-078aa8aac8e9cde42"

  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  name = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "ansible" {
    playbook_file = "/Users/ashwini.borkar/src/Talent-Academy/Terraform_Labs/ec2-lab/playbooks/playbooks.yml"
  }
  //   provisioner "shell" {
  //   environment_vars = [
  //     "FOO=hello world",
  //   ]
  //   inline = [
  //     "echo Installing Redis",
  //     "sleep 30",
  //     "sudo apt-get update",
  //     "sudo apt-get install -y redis-server",
  //     "echo \"FOO is $FOO\" > example.txt",
  //   ]
}

