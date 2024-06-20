variable "regions" {
  type = map(any)
}
variable "product" {
  type    = string
  default = "bmpd"
}
variable "use_case" {
  type = string
}
variable "cluster_config" {
  type = any
}

