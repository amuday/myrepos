package main

warn[msg] {
    instance_type := input.resource.aws_instance.web.instance_type
    contains(instance_type,"m7g.8xlarge")
    msg := "EC2 instance should not be m7g.8xlarge"
}


violation[msg] {
    subnet_id := input.resource.aws_instance.web.subnet_id
    contains(subnet_id,"public")
    msg := "EC2 instnace should not in public subnet"
}

deny[msg] {
    not input.resource.aws_instance.web.tags
    msg := "EC2 instnace should have tags"
}