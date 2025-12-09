output "public_subnet_1_id" {
  description = "ID of the first public subnet"
  value       = aws_subnet.PublicSubnet1.id
}

output "public_subnet_2_id" {
  description = "ID of the second public subnet"
  value       = aws_subnet.PublicSubnet2.id
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "private_subnet_ids" {
  description = "List of IDs of the private subnets"
  value       = [aws_subnet.PrivateSubnet1.id, aws_subnet.PrivateSubnet2.id]
}