output "mylistoutput" {
  value = var.mylist
}

output "mylistval" {
  value = var.mylist[0]
}

output "mymapoutput" {
  value = var.mymap
}

output "mymapval" {
  value = var.mymap["key1"]
}

output "mymapval2" {
  value = lookup(var.mymap, "keydoesnot exist", "this is default value")
}

# returns map output
output "mysetval" {
  value = {
    for val in var.myset : val => val < 5 ? 5 : 10
  }
}

# returns list output
output "mysetval_1" {
  value = [
    for val in var.myset : val < 5 ? 5 : 10
  ]
}


output "myobjval" {
  value = var.myobject["marks"][0]
}