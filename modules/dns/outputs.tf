output "platform_dns" {
  value = trimsuffix(google_dns_record_set.platform.name,".")
}