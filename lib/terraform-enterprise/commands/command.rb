require 'json'

require 'terraform-enterprise-client'
require 'terraform-enterprise/commands/formatter'
require 'terraform-enterprise/commands/strings'

module TerraformEnterprise
  module Commands
    class Command < Thor
      class_option :host, type: :string, desc: 'Set host address for private Terraform Enterprise'
      class_option :token, type: :string, desc: 'Set the auth token, defaults to TERRAFORM_ENTERPRISE_TOKEN environment variable'
      class_option :color, type: :boolean, default: true, desc: 'If disabled the ANSI color codes will not be used'
      class_option :except, type: :array, desc: 'List of fields that should not be displayed'
      class_option :only, type: :array, desc: 'List of fields that should be displayed'
      class_option :all, type: :boolean, default: false, desc: "Return all fields, not just summary"
      class_option :value, type: :boolean, default: false, desc: 'Only return the value; i.e. do not show keys'
      class_option :debug, type: :boolean, default: false, desc: 'Show debug logs'

      no_commands do
        def render(obj, default_options={})
          calculated_options = if(options[:all])
            symbolize_keys(options.to_h)
          else
            symbolize_keys(default_options).merge(symbolize_keys(options.to_h))
          end
          TerraformEnterprise::Commands::Formatter.render obj, calculated_options
        end

        def client
          settings           = { }
          settings[:api_key] = options[:token] || ENV['TFE_TOKEN']
          settings[:host]    = options[:host] if options[:host]
          settings[:debug]   = options[:debug] if options[:debug]
          TerraformEnterprise::Client.new(settings)
        end

        private

        def symbolize_keys(hash)
          JSON.parse(JSON[hash], symbolize_names: true)
        end

      end
    end
  end
end