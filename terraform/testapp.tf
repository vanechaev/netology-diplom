resource "null_resource" "testapp_deployment" {
  provisioner "local-exec" {
    command = "kubectl apply -f ../k8s/dep-testapp.yaml"
  }
  depends_on = [
    null_resource.grafana_service
  ]
}

resource "null_resource" "testapp_service" {
  provisioner "local-exec" {
    command = "kubectl apply -f ../k8s/s-testapp.yaml"
  }
  depends_on = [
    null_resource.testapp_deployment
  ]
}
