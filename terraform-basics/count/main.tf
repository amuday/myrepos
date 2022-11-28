resource "local_file" "pet" {

  count = length(var.filename)

  filename = var.filename[count.index]
  content  = "hello pet!!"

}

output "pets" {
  value     = local_file.pet[*].filename
}