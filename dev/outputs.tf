output "ec2_public_ip" {
  description = "EC2 Public IP"
  value       = module.ec2.ec2_public_ip   # ← EC2 MODULE SE AAYA
}

output "ec2_public_dns" {
    description = "EC2 Public DNS"
    value = module.ec2.ec2_public_dns
}