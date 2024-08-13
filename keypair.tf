#Creating Key Pair
resource "aws_key_pair" "keypair" {
  key_name   = "test-key"
  public_key = file("${path.module}/public key")
}