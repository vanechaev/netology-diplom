variable "cloud_id" {
  type = string
  default = "b1grubm3o3lpb9lh25up"
}

variable "folder_id" {
  type = string
  default = "b1g012f6rgs30ucfn1kd"
}

variable "default_zone" {
  type    = string
  default = "ru-central1-a"
}

variable "bucket_name" {
  type    = string
  default = "diplom-bucket"
}

variable "a_zone" {
  type    = string
  default = "ru-central1-a"
}

variable "b_zone" {
  type    = string
  default = "ru-central1-b"
}

variable "d_zone" {
  type    = string
  default = "ru-central1-d"
}

variable "vpc_name" {
  type    = string
  default = "net"
}

variable "vm_resources" {
  type = map(any)
  default = {
    default = {
      "cores"     = 2
      "memory"        = 2
      "core_fraction" = 20
    }
    master = {
      "cores"     = 2
      "memory"        = 2
      "core_fraction" = 20
    }
    worker = {
      "cores"     = 2
      "memory"        = 2
      "core_fraction" = 20
    }
  }
}
