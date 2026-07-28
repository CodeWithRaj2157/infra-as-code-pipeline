config {
  force = false
}

plugin "terraform" {
  enabled = true
}

rule "terraform_unused_declarations" {
  enabled = false
}
