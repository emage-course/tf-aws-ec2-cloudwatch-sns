
########################################################
# Output the VPC ID
########################################################
output "vpc_id" {
  value = aws_vpc.app_vpc.id
}

########################################################
# Output the Public Subnets
########################################################
output "public_subnets" {
  value = aws_subnet.public_subnets.*.id
}

########################################################
# Output the Security Group for EC2
########################################################
output "security_group_ec2" {
  value = aws_security_group.sg.*.id
}
