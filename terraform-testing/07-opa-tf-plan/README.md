
https://www.openpolicyagent.org/docs/latest/terraform/

https://developer.hashicorp.com/terraform/tutorials/cloud/drift-and-opa

https://www.conftest.dev/options/

https://github.com/hashicorp/learn-terraform-drift-and-opa

https://github.com/ned1313/hashiconf-global-opa


terraform init
terraform plan --out tfplan.binary
terraform show -json tfplan.binary > tfplan2.json


conftest test -p policy\ terraform\tfplan.json
conftest test -p policy\ terraform\tfplan.json -o table

