resource "null_resource" "my-null-rs" {

  provisioner "local-exec" {
    command     = "echo create date and time is %date% %time% >> time.txt"
    working_dir = "output"
  }

  provisioner "local-exec" {
    command     = "echo destroy date and time is %date% %time% >> destroytime.txt"
    working_dir = "output"
    when        = destroy
  }

/*
  provisioner "file" {
    source = "output/time.txt"
    destination = "backup/"
  }

*/

}