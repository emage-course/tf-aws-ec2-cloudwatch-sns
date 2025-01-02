
########################################################################################################
# Create output file
########################################################################################################

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "security_groups_ec2" {
  value = module.vpc.security_group_ec2
}

output "ec2_instance_ids" {
  value = module.web.instance_ids
}

output "public_ip" {
  value = module.web.public_ip
}

# output "public_ip" {
#   value = "http://${module.web.public_ip}"

# }
