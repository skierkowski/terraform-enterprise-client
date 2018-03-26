require 'terraform-enterprise/client/resource'

module TerraformEnterprise
  module API
    class Response
      attr_reader :code, :body, :data, :resource, :resources, :errors
      def initialize(rest_client_response)
        @code = rest_client_response.code
        @body = parse(rest_client_response.body)
        @data = (@body.is_a?(Hash) && @body['data']) ? @body['data'] : @body
        if @data.is_a?(Hash)
          @resource = TerraformEnterprise::API::Resource.new(@data) 
        end
        if @data.is_a?(Array) && @data.all?{|a| a.is_a?(Hash)}
          @resources = @data.map do |item|
            TerraformEnterprise::API::Resource.new(item)
          end
        end
        if has_errors?
          @errors = @body['errors']
        end
      end

      def has_errors?
        @body.is_a?(Hash) && @body['errors'] && @body['errors'].is_a?(Array)
      end

      private

      def parse(str)
        JSON.parse(str)
      rescue JSON::ParserError
        str
      end
    end
  end
end
