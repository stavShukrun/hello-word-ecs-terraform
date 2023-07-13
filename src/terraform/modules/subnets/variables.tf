variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "subnets" {
  type = list(object({
    availability_zone = string,
    is_public = bool,
    tags = map(string)
  }))
}