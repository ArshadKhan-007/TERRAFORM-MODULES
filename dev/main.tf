module "ec2" {
    source = "../modules/EC2"
    instance_type = var.instance_type
    ami_id = var.ami_id
    volume_type = var.volume_type
    volume_size = var.volume_size
}