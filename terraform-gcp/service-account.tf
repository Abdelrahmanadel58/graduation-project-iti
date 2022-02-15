# service account for gke
#resource "google_service_account" "gke" {
#  account_id   = "service-acount-for-gke-project"
#  display_name = "service-acount-for-gke-project"
#}
#
#resource "google_project_iam_binding" "gkeeee" {
# project = var.account_id
# role = "roles/container.admin"
# depends_on = [
# google_service_account.gke
# ]
# members = [
# "serviceAccount:${google_service_account.gke.email}"
# ]
#}


# service account for vm instance
resource "google_service_account" "vm" {
  account_id   = "service-acount-for-vm-project"
  display_name = "service-acount-for-vm-project"
}

# resource "google_service_account_iam_binding" "admin-account-iam-vm" {
resource "google_project_iam_binding" "vm1" {
 project = var.account_id
 role = "roles/container.admin"
 depends_on = [
 google_service_account.vm
 ]
 members = [
 "serviceAccount:${google_service_account.vm.email}"
 ]
}