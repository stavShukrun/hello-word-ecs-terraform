variable "vpc_cidr" {
    type = string
}

variable "vpc_tags" {
    type = object({
        Name = string
    })
}