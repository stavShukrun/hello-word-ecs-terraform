resource "aws_route_table_association" "private_rt_1" {
  subnet_id      = var.subnets_private_ids[0]
  route_table_id = var.route_table_ids.route_table_private_id
}

resource "aws_route_table_association" "private_rt_2" {
  subnet_id      = var.subnets_private_ids[1]
  route_table_id = var.route_table_ids.route_table_private_id
}

resource "aws_route_table_association" "public_rt_1" {
  subnet_id      = var.subnets_public_ids[0]
  route_table_id = var.route_table_ids.route_table_public_id
}

resource "aws_route_table_association" "public_rt_2" {
  subnet_id      = var.subnets_public_ids[1]
  route_table_id = var.route_table_ids.route_table_public_id
}

## lookup(search key) , contains(exsist or not)