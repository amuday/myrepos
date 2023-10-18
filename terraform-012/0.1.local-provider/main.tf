resource "local_file" "my_file" {
    filename = "C:/Users/udayk/AppData/Local/Temp/test.txt"
    content = "hello world!"

    lifecycle {
      #create_before_destroy = true
      #prevent_destroy = true # cant destroy using apply and destroy
      ignore_changes = [ 
        content  # ignores changes in content argument
       ]
    }
  
}


data "local_file" "my_file" {
  filename = local_file.my_file.filename
}

output "file_content" {
  value = data.local_file.my_file.content
}



