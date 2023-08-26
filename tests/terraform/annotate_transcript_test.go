package test

import (
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformWithAnnotations(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		// Set the path to the Terraform code that will be tested.
		TerraformDir: "../../",

		// Variables to pass to our Terraform code using VAR=value environment variables
		Vars: map[string]interface{}{
			"project_id": "narrativai",
			"region":     "europe-west2",
		},

		// Variables to pass to our Terraform code using VAR=value environment variables
		EnvVars: map[string]string{
			"GOOGLE_CLOUD_PROJECT": "narrativai",
		},

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	}

	defer terraform.Destroy(t, terraformOptions)

	// Initialize and Apply Terraform
	terraform.InitAndApply(t, terraformOptions)

	// Validate your code works as expected
	annotateTranscriptUrl := terraform.Output(t, terraformOptions, "annotate_transcript_url")
	assert.True(t, strings.Contains(annotateTranscriptUrl, "https://"))
}
