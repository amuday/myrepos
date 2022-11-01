
output "output_ami" {
 value = data.aws_ami.get_amis 
}


output "op_ami_ids" {
  #value = data.aws_ami_ids.ubuntu
  value = [for id in data.aws_ami_ids.ubuntu: id ]
}


/*
output "ami_name" {
    value = "${data.aws_ami.get_amis}"
  
}*/


