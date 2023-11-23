# you can use the package as policy and dont need to import. Here we want separate package
package policy_test

import data.policy.allow

# rego rule should start with test
test_allow_is_false_by_default {
    # below both are same
    #allow == false
    not allow
}

test_allow_admin {
    # passing input for the test
    allow with input as {
        "user": {       
        "roles": ["admin"]
        }
    }
}

test_deny_if_not_admin {
    # passing input for the test
    not allow with input as {
        "user": {       
        "roles": ["developer"]
        }
    }

    not allow with input as {
        "user": {       
        "roles": ["developer advocate"]
        }
    }
}


test_allow_if_get_on_public {
    allow with input as {
        "request": {
            "method": "GET",
            "path": "/public"
        }
    }

    allow with input as {
        "request": {
            "method": "GET",
            "path": "/public/pictures"
        }
    }
}

# negative test
test_deny_if_not_get_on_public {
     not allow with input as {
        "request": {
            "method": "PUT",
            "path": "/public"
        }
    }

    not allow with input as {
        "request": {
            "method": "DELETE",
            "path": "/public/pictures"
        }
    }
}

test_deny_if_not_get_on_non_public {
     not allow with input as {
        "request": {
            "method": "GET",
            "path": "/private"
        }
    }
}