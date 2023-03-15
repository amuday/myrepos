package main


deny[msg] {
    input.resource.aws_security_group.web.ingress.to_port == 0
    msg := "Web security group should allow ingress on app port 0"
}