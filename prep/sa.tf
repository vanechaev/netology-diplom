resource "yandex_iam_service_account" "tf-dip" {
  name = "tf-dip"
}

resource "yandex_resourcemanager_folder_iam_member" "tf-dip-editor" {
  folder_id  = var.folder_id
  role       = "editor"
  member     = "serviceAccount:${yandex_iam_service_account.tf-dip.id}"
  depends_on = [yandex_iam_service_account.tf-dip]
}

resource "yandex_iam_service_account_static_access_key" "sa-key" {
  service_account_id = yandex_iam_service_account.tf-dip.id
  depends_on         = [yandex_resourcemanager_folder_iam_member.tf-dip-editor]
}

resource "yandex_storage_bucket" "s3-backet" {
  bucket     = var.bucket_name
  access_key = yandex_iam_service_account_static_access_key.sa-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-key.secret_key

  anonymous_access_flags {
    read = false
    list = false
  }
  force_destroy = true
  depends_on    = [yandex_iam_service_account_static_access_key.sa-key]
}

resource "local_file" "backend-conf" {
  content    = <<EOT
access_key = "${yandex_iam_service_account_static_access_key.sa-key.access_key}"
secret_key = "${yandex_iam_service_account_static_access_key.sa-key.secret_key}"
EOT
  filename   = "../terraform/backend.key"
  depends_on = [yandex_storage_bucket.s3-backet]
}

resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "yc iam key create --folder-name default --service-account-name tf-dip --output ../terraform/key.json"
  }
  depends_on = [yandex_resourcemanager_folder_iam_member.tf-dip-editor]
}
