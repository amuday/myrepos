resource "local_file" "my_file" {
  filename = "C:/Users/udayk/AppData/Local/Temp/test.txt"
  content  = "hello world!"

  lifecycle {
    replace_triggered_by = [
      null_resource.always_run
    ]
  }

}

resource "null_resource" "always_run" {
  triggers = {
    timestamp = "${timestamp()}"
  }
}




data "local_file" "my_file" {
  filename = local_file.my_file.filename
}

output "file_content" {
  value = data.local_file.my_file.content
}



