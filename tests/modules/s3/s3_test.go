package test

import (
	"testing"
	"os"
	"fmt"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestS3(t *testing.T) {
	t.Parallel()

	dir, _ := os.Getwd()
	fmt.Println(dir)

	aws_region := "us-east-1"

	Environment := "test-stage"

	expected_s3_bucket_name := Environment+"-sample-bucket"

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../../modules/s3/",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"Environment":Environment,
		},

		// Environment variables to set when running Terraform
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": aws_region,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	aws.AssertS3BucketExists(t, aws_region, expected_s3_bucket_name)

	sample_bucket := aws.FindS3BucketWithTag(t, aws_region, "Name", Environment+" Sample Bucket")

	assert.NotNil(t, sample_bucket)
}
