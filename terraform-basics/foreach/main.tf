resource "local_file" "pet" {

  for_each = toset(var.filename)

  filename = each.value
  content  = "hello pet!!"

}

output "pets" {
  value     = local_file.pet
  sensitive = true
}