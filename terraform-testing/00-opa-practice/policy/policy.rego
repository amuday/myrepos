package policy

# by default allow does not return anything in case the condition is not true. 
# Setting false as default
default allow = false

# below allows are logical OR conditions.
allow {
  input.user.roles[_] == "admin"
}

allow {
    # to allow anything from public
    # below two conditions are logical AND
    result := startswith(input.request.path, "/public")
    input.request.method == "GET"
}