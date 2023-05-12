
data "aws_ssm_parameter" "param1" {
  name = "param1"
}


data "aws_ssm_parameter" "param2" {
  name = "/blueworks/api/clinetid"
}