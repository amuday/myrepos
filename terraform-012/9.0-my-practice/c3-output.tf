
output "output_ami" {
 value = data.aws_ami.get_amis 
}


output "op_ami_ids" {
  #value = data.aws_ami_ids.ubuntu
  value = [for id in data.aws_ami_ids.ubuntu: id ]
}


output "routetables" {
  value = [for rt in data.aws_route_tables.main.ids: rt.id ]
  #value = data.aws_route_tables.main.ids
  
}

/*
output "ami_name" {
    value = "${data.aws_ami.get_amis}"
  
}*/


