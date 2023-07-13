resource "aws_subnet" "subnet" {
  for_each = {for key, value in var.subnets: key => value}
  vpc_id = var.vpc_id
  cidr_block        = cidrsubnet(var.vpc_cidr, 3, each.key)
  availability_zone = each.value.availability_zone
  map_public_ip_on_launch = each.value.is_public
  tags = each.value.tags
}