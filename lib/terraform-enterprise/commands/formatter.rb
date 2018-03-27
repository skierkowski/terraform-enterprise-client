require 'yaml'
require 'colorize'
require 'terminal-table'

require 'terraform-enterprise-client'

module TerraformEnterprise
  module Commands
    module Formatter
      def self.render(obj, options={})
        String.disable_colorization = !options[:color]
        if obj.is_a?(TerraformEnterprise::API::Response)
          if obj.code >= 200 && obj.code < 300
            if obj.resources
              puts render_resource_table(obj.resources, options)
            elsif obj.resource
              puts render_resource(obj.resource, options) 
            else
              puts "Success (#{obj.code})".green
            end
          elsif obj.errors?
            obj.errors.each do |error|
              if error['status'] && error['title']
                puts "Error (#{error['status']}): #{error['title']}".red
              else
                puts "Error (#{obj.code}): #{error}".red
              end
              exit(false)
            end
          else
            puts "Unknown server response (#{obj.code})".yellow
            puts obj.body
            exit(false)
          end
        else
          puts "Unknown content".yellow
          puts obj
          exit(false)
        end
      end

      private

      def self.parse_resource(resource, options)
        parsed_resource = flatten_dotted_hash(resource.attributes)
        parsed_resource = {'id' => resource.id}.merge(parsed_resource) if resource.id
        (options[:except] || []).each do |excluded|
          parsed_resource.delete_if {|key,value| key.to_s.start_with?(excluded.to_s) }
        end
        if options[:only] && options[:only].length > 0
          parsed_resource.select! do |key, value|
            options[:only].any?{ |included| key.to_s.start_with?(included.to_s) }
          end
        end
        parsed_resource
      end

      def self.render_resource(resource, options)
        parsed_resource = parse_resource(resource, options)
        parsed_resource.keys.map do |key|
          value = parsed_resource[key]
          options[:value] ? value : "#{key.bold}: #{value}"
        end.join("\n")
      end

      def self.render_resource_table(resources, options)
        if options[:table] && !options[:value]
          parsed_resources = resources.map{|resource| parse_resource(resource,options)}
          keys = parsed_resources.map{|resource| resource.keys }.flatten.uniq
          rows = parsed_resources.map do |resource|
            keys.map{|key| resource[key]}
          end
          table = Terminal::Table.new headings: keys, rows: rows
          table
        else
          out = resources.map{|resource| render_resource(resource, options)}.join("\n#{'-' * 10}\n")
        end
      end

      def self.flatten_hash(h,f=[],g={})
        return g.update({ f=>h }) unless h.is_a?(Hash) || h.is_a?(Array)
        h.each { |k,r| flatten_hash(r,f+[k],g) } if h.is_a?(Hash)
        h.each_with_index { |r, k| flatten_hash(r,f+[k],g) } if h.is_a?(Array)
        g
      end

      def self.flatten_dotted_hash(source)
        flat = flatten_hash(source)
        flat.keys.each_with_object({}) { |key, h| h[key.join('.')] = flat[key] }  
      end
    end
  end
end