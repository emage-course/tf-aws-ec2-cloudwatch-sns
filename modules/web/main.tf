###############################################################################
# Get latest Amazon Linux 2023 AMI
###############################################################################
data "aws_ami" "amazon-linux-2023" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

###############################################################################
# Create the Linux EC2 Web server
###############################################################################
resource "aws_instance" "web" {
  ami             = data.aws_ami.amazon-linux-2023.id
  instance_type   = var.instance_type
  key_name        = var.instance_key
  security_groups = var.security_group_ec2
  monitoring      = true # Enabling will cost more charges!

  count     = length(var.public_subnets)
  subnet_id = element(var.public_subnets, count.index)


  user_data = <<-EOF
  #!/bin/bash
  sudo yum -y install httpd git
  sudo yum -y  update
  cd /tmp
  git clone https://github.com/emage-course/portfolio.git
  sleep 15s
  cd /tmp/portfolio/website
  cp -r *  /var/www/html/
  sudo systemctl stop httpd
  sudo systemctl start httpd
  sudo systemctl enable httpd
EOF

  tags = merge(var.common_tags, {
    Name = "${var.naming_prefix}-${count.index + 1}"
  })
}