$LOAD_PATH.unshift(File.expand_path("./lib"))

require 'terraform_enterprise_api'

client = TerraformEnterprise::Client.new(api_key:ENV['TERRAFORM_ENTERPRISE_TOKEN'])


puts client.workspaces.get(organization:'adobe-demo')