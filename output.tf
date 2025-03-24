output "public-dns" {
  value = aws_instance.my-ec2.public_dns
}

output "Execution-time" {
  value = timestamp()
}