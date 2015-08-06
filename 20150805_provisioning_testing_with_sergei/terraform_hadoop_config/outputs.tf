output "ambari.ip" {
  value = "${aws_instance.ambari.public_ip}"
}
output "bosun-server.ip" {
  value = "${aws_instance.bosun-server.public_ip}"
}
output "bosun-store00.ip" {
  value = "${aws_instance.bosun-store00.public_ip}"
}
output "bosun-store01.ip" {
  value = "${aws_instance.bosun-store01.public_ip}"
}
output "bosun-store02.ip" {
  value = "${aws_instance.bosun-store02.public_ip}"
}
output "bosun-store03.ip" {
  value = "${aws_instance.bosun-store03.public_ip}"
}
