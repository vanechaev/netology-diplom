resource "null_resource" "gitlab_agent" {
  provisioner "local-exec" {
    command = "helm repo add gitlab https://charts.gitlab.io && helm repo update && helm upgrade --install gitlab-agent gitlab/gitlab-agent --namespace gitlab-agent-gitlab-agent --create-namespace --set image.tag=v16.11.0-rc1 --set config.token=glagent-RzVLcJfZ7w14Za57LTp2inUJ3AyDSjyyTUU2FPop2YspMvskzg --set config.kasAddress=wss://kas.gitlab.com"
  }
  depends_on = [
    null_resource.gitlab_agent
  ]
}
