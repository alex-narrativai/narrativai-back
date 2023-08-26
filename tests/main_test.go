package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/gcp"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestTerraform(t *testing.T) {
	terraformOptions := &terraform.Options{
		TerraformDir: ".",
	}

	// Clean up resources at the end of the test
	defer terraform.Destroy(t, terraformOptions)

	// Initialize and apply Terraform code
	terraform.InitAndApply(t, terraformOptions)

	// Get the GCP project ID
	projectID := gcp.GetGoogleProjectIDFromEnvVar(t)

	// Check that the GCP Function for Transcript Processing exists
	transcriptProcessingName := terraform.Output(t, terraformOptions, "transcript_processing_name")
	gcp.AssertCloudFunctionExists(t, projectID, "europe-west2", transcriptProcessingName)

	// Check that the GCP Function for GPT-4 Interaction exists
	gpt4InteractionName := terraform.Output(t, terraformOptions, "gpt4_interaction_name")
	gcp.AssertCloudFunctionExists(t, projectID, "europe-west2", gpt4InteractionName)

	// Check that the GCP Function for Neo4j CRUD API exists
	neo4jCrudApiName := terraform.Output(t, terraformOptions, "neo4j_crud_api_name")
	gcp.AssertCloudFunctionExists(t, projectID, "europe-west2", neo4jCrudApiName)

	// Check that the GCP Memorystore (Redis) instance exists
	memorystoreName := terraform.Output(t, terraformOptions, "memorystore_name")
	gcp.AssertMemorystoreInstanceExists(t, projectID, "europe-west1", memorystoreName)
}
