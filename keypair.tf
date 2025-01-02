
resource "aws_key_pair" "workshopkeypair" {
  key_name   = "workshopkeypair"
  public_key = file("~/.ssh/id_rsa.pub")
}
