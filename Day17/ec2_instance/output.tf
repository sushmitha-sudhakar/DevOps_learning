output "id" {
  value = aws_instance.test_instance[*].id
}