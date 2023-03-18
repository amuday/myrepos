
## Documentation
    https://learn.microsoft.com/en-us/azure/developer/terraform/best-practices-end-to-end-testing

## code is taken from
    https://github.com/Azure/terraform/tree/master/samples/end-to-end-testing



# guidelines
    Make sure your test case name is starting with prefix TestTerraform, test keyword will be used by go compiler to identify the methods as test method.

    every golang file must have a package name at the beginning of the file which specify that the current file will be exported as this given package name, the given name can be shared by multiple files with-in same directory if needed.

# steps to run
    export TEST_SSH_KEY_PATH="~/.ssh/id_rsa"
    set TEST_SSH_KEY_PATH=~/.ssh/id_rsa
    set TEST_SSH_KEY_PATH="C:/Users/udayk/.ssh/id_rsa"
