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

        return unless @body.is_a?(Hash)

        @data      = @body['data'] || @body
        @errors    = @body['errors'] || []
        @resource  = Resource.new(@body) if @data.is_a?(Hash)
        @resources = @data.map { |row| Resource.new('data' => row) } if @data.is_a?(Array)
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
