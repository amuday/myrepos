# output variables will be displayed in alphabetical order in the console
/*
output "vpcid" {
  value = aws_vpc.myvpc.id
}
*/

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

output "get_list_value" {
  value = var.mylist[0]
}

output "get_map_value" {
  value = var.mymap["key1"]
}

output "myserver_1" {
  value = var.servers[*].region
}

# myserver_names = [ "server1",  "server2",]
output "myserver_names" {
  value = [ for val in var.servers : val.name ]
}

/*
myserver_tags = {           
  "server1" = tolist([      
    "web",                  
    "development",          
  ])                        
  "server2" = tolist([      
    "web",                  
    "staging",              
  ])                        
}
*/                           
output "myserver_tags" {
  value = { for val in var.servers : val.name => val.tags }
}

output "capacity_reservation_preference"{
  value = var.ec2_instances.one.capacity_reservation_specification[*].capacity_reservation_preference

  # var.ec2_instances is object with 3 attributes error for below one
  # As you did not specify one, two or three
  # value = var.ec2_instances[0].capacity_reservation_specification[*].capacity_reservation_preference

}


output "paths" {
  value = [path.cwd, path.module, path.root]
}

output "meta_info" {
  value = [terraform.workspace]
  
}