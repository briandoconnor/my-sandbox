output "ambari.ip" {
  value = "${aws_instance.ambari.public_ip}"
}
output "zoo-name.ip" {
  value = "${aws_instance.zoo-name.public_ip}"
}
output "kafka-0.ip" {
  value = "${aws_instance.kafka-0.public_ip}"
}
output "kafka-1.ip" {
  value = "${aws_instance.kafka-1.public_ip}"
}
output "spark-0.ip" {
  value = "${aws_instance.spark-0.public_ip}"
}
output "spark-1.ip" {
  value = "${aws_instance.spark-1.public_ip}"
}
output "spark-2.ip" {
  value = "${aws_instance.spark-2.public_ip}"
}
