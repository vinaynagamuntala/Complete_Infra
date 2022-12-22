output "One_vpc" {
  value = aws_vpc.One_vpc.id
}

output "bastion" {
  value = aws_instance.bastion.public_ip
}

output "apache" {
  value = aws_instance.apache.private_ip
}

output "tomcat" {
  value = aws_instance.tomcat.private_ip
}

output "jenkins" {
  value = aws_instance.jenkins.private_ip
}