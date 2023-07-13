variable "vpc_id" {
    type = string
    description = "The vpc ID from the network module"
}

variable "subnets_public_ids" {
    type = list(string)
}