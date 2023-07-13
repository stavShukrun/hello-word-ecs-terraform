variable "subnets_public_ids" {
    type = list(string)
}

variable "subnets_private_ids" {
    type = list(string)
}

variable "route_table_ids" {
  type = map(string)
}