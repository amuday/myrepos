# opa-practice

https://github.com/ned1313/learning-opa-and-terraform/tree/main/3-parsing-terraform-plans
https://github.com/anderseknert


Install
    https://www.openpolicyagent.org/docs/latest/#running-opa
    F:/software is already in path
    Rename the exe to opa

# commands
    opa eval --data policy.rego "data.policy.allow"
    opa eval --format raw --data policy.rego "data.policy.allow"

    opa eval --format raw --data policy.rego --input input.json "data.policy.allow"

    # remove admin role from json
    opa eval --format raw --data policy.rego --input input.json "data.policy.allow"

    # Add test and run below
    opa test .


# terraform
terraform init
terraform plan -out="tfplan.binary"
terraform show -json "tfplan.binary" > "tfplan.json"

 opa run tfplan.json
  get high level 
 data[key]

 data.planned_values.root_module.resources[0]
 data.resource_changes[keys]
 

