resource "null_resource" "gitlab_agent" {
  provisioner "local-exec" {
    command = "helm repo add gitlab https://charts.gitlab.io && helm repo update && helm upgrade --install gitlab-agent gitlab/gitlab-agent --namespace gitlab-agent --create-namespace --set image.tag=v1.1.1 --set config.token=glpat-sUzANzG7jHEyB--3V9gM --set config.kasAddress=wss://kas.gitlab.com"
  }
  depends_on = [
    null_resource.gitlab_agent
  ]
}
