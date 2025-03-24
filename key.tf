resource "tls_private_key" "my-key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "keypair" {
  key_name   = "ec2-key"
  public_key = tls_private_key.my-key.public_key_openssh
}

resource "local_file" "private-key" {
  filename = "${aws_key_pair.keypair.key_name}.pem"
  content  = tls_private_key.my-key.private_key_pem
}