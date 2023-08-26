resource "google_redis_instance" "example" {
  name           = var.name
  tier           = var.tier
  memory_size_gb = var.capacity
  region         = var.region

  redis_configs = {
    # Redis configurations
  }
}
