# output variables will be displayed in alphabetical order in the console

output "vpcname" {
  value = var.vpcname
}

output "mylist" {
  value = var.mylist
}

output "mytuple" {
  value = var.mytuple
}

output "myobject" {
  value = var.myobject
}

output "myserver_1" {
  value = var.servers[*].region
}

output "vpcid" {
  value = aws_vpc.myvpc.id
}
