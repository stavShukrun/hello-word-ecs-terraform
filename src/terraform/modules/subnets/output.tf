output "subnets_public" {
  value  = [for subnet in aws_subnet.subnet: subnet.id if subnet.map_public_ip_on_launch == true]
}

output "subnets_private" {
  value  = [for subnet in aws_subnet.subnet: subnet.id if subnet.map_public_ip_on_launch == false]
} 

