resource "aws_instance" "jenkins-vm" {
    ami = var.ec2_ami_id
    instance_type = "t2.medium"
    key_name = "nvKey"
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.one-SG.id]
    subnet_id = aws_subnet.one-public-subnet.id
    user_data = file("install_jenkins.sh")
    tags = {
        name = "jenkins-vm"
    }
}