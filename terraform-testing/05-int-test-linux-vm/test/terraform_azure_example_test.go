package test

import (
	"fmt"
	"reflect"
	"testing"

	"github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/compute/armcompute"
	//"github.com/Azure/azure-sdk-for-go/services/compute/mgmt/2019-07-01/compute"
	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// An example of how to test the Terraform module in examples/terraform-azure-example using Terratest.
func TestTerraformAzureExample(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../src/",
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	vmName := terraform.Output(t, terraformOptions, "vm_name")
	resourceGroupName := terraform.Output(t, terraformOptions, "resource_group_name")

	// Look up the size of the given Virtual Machine
	actualVMSize := string(azure.GetSizeOfVirtualMachine(t, vmName, resourceGroupName, ""))
	expectedVMSize := string(armcompute.VirtualMachineSizeTypes(terraform.Output(t, terraformOptions, "vm_size")))

	fmt.Printf("actualVMSize: %s\n", reflect.TypeOf(actualVMSize))
	fmt.Printf("expectedVMSize: %s\n", reflect.TypeOf(expectedVMSize))

	// Test that the Virtual Machine size matches the Terraform specification
	assert.Equal(t, expectedVMSize, actualVMSize)
}
