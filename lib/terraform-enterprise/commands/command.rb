require 'json'

require 'terraform-enterprise-client'
require 'terraform-enterprise/commands/formatter'
require 'terraform-enterprise/commands/strings'
require 'terraform-enterprise/commands/util'

module TerraformEnterprise
  module Commands
    # Base class for all commands
    class Command < Thor
      include TerraformEnterprise::Commands
      include TerraformEnterprise::Util::Tar

      CMD_STR = STRINGS[:options]

      class_option :host, type: :string, desc: CMD_STR[:host]
      class_option :token, type: :string, desc: CMD_STR[:token]
      class_option :color, type: :boolean, default: true, desc: CMD_STR[:color]
      class_option :except, type: :array, desc: CMD_STR[:except]
      class_option :only, type: :array, desc: CMD_STR[:only]
      class_option :all, type: :boolean, default: false, desc: CMD_STR[:all]
      class_option :value, type: :boolean, default: false, desc: CMD_STR[:value]
      class_option :debug, type: :boolean, default: false, desc: CMD_STR[:debug]

      no_commands do
        def render(obj, default_options = {})
          normalized_options = symbolize_keys(options.to_h)
          calculated_options =
            if options[:all]
              normalized_options
            else
              symbolize_keys(default_options).merge(normalized_options)
            end
          Formatter.render obj, calculated_options
        end

        def client
          settings         = {}
          settings[:token] = options[:token] || ENV['TFE_TOKEN']
          settings[:host]  = options[:host] if options[:host]
          settings[:debug] = options[:debug] if options[:debug]
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
