data "aws_ssm_parameter" "ami_id" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "my-ec2" {
  ami                    = data.aws_ssm_parameter.ami_id.value
  instance_type          = var.instance-type
  vpc_security_group_ids = [aws_security_group.ec2-sg.id]
  key_name               = aws_key_pair.keypair.key_name
  subnet_id              = aws_subnet.public-subnet-1.id

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(local_file.private-key.filename)
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y && sudo systemctl start httpd && sudo systemctl enable httpd",
      "echo '<h1>This website is using Terraform Provisionner >' index.html",
      "sudo mv index.html /var/www/html/"
    ]
  }

  tags = {
    Name = "webserver"
  }
}