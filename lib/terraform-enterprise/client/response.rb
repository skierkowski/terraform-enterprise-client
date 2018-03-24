module TerraformEnterprise
  module API
    class Response
      attr_reader :code, :body, :data, :resource, :resources
      def initialize(rest_client_response)
        @code = rest_client_response.code
        @body = parse(rest_client_response.body)
        @data = @body['data'] ? @body['data'] : @body
      end

      private

      def parse(str)
        JSON.parse(str)
      rescue JSON::ParseError
        str
      end
    end
  end
end
