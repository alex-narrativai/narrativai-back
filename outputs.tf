# Global outputs.tf

output "transcript_processing_url" {
  value = module.transcript_processing.url
}

output "gpt4_interaction_url" {
  value = module.gpt4_interaction.url
}

output "neo4j_crud_api_url" {
  value = module.neo4j_crud_api.url
}

output "memorystore_ip" {
  value = module.memorystore.ip
}
