data "external" "list_files" {
  program = ["sh", "-c", "find ${var.source_directory} -type f"]
}
