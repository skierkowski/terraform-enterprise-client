require 'terraform-enterprise/client/resource'

module TerraformEnterprise
  module API
    # Wrapps the JSON-API HTTP response for easy access to data and resources
    class Response
      include TerraformEnterprise::API

      attr_reader :code, :body, :data, :resource, :resources, :errors
      def initialize(rest_client_response)
        @code = rest_client_response.code
        @body = parse(rest_client_response.body)
        @data = (@body.is_a?(Hash) && @body['data']) ? @body['data'] : @body

        @resource = Resource.new(@data) if @data.is_a?(Hash)
        if @data.is_a?(Array) && @data.all? { |a| a.is_a?(Hash) }
          @resources = @data.map { |item| Resource.new(item) }
        end
        @errors = @body['errors'] if errors?
      end

      def errors?
        @body.is_a?(Hash) && @body['errors'] && @body['errors'].is_a?(Array)
      end

      def success?
        @code.between?(200, 299)
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
