resource "aws_vpc" "stav-vpc" {
    cidr_block = var.vpc_cidr
    tags = var.vpc_tags
}