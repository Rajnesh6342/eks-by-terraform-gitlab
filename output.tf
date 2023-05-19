output "public_ip_of_mpf-orchestrator_server" {
  description = "this is the public IP of mpf-orchestrator Server"
  value = aws_instance.mpf-orchestrator-server.public_ip
}

output "private_ip_of_mpf-orchestrator_server" {
  description = "this is the private IP of mpf-orchestrator Server"
  value = aws_instance.mpf-orchestrator-server.private_ip
}
