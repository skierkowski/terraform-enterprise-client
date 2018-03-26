require 'terraform-enterprise/client/response'

module TerraformEnterprise
  module API
    class Request
      attr_accessor :base

      def initialize(api_key:, host: 'https://app.terraform.io/api/v2', debug: false)
        @base    = host
        @api_key = api_key
        @debug   = debug
        @headers = {
          'Authorization' => "Bearer #{@api_key}",
          'Content-Type' => 'application/vnd.api+json'
        }
      end

      def get(*path)
        data = path.pop if path.last.is_a?(Hash)
        request(:get, path, data)
      end

      def delete(*path)
        data = path.pop if path.last.is_a?(Hash)
        request(:delete, path,data)
      end

      def post(*path)
        data = path.pop if path.last.is_a?(Hash)
        request(:post, path, data)
      end

      def put(*path)
        data = path.pop if path.last.is_a?(Hash)
        request(:put,data,data)
      end

      def patch(*path)
        data = path.pop if path.last.is_a?(Hash)
        request(:patch,path,data)
      end

      def request(method, path, data={}, headers={})
        request = {
          method:  method,
          url:     uri(path),
          headers: @headers.merge(headers || {})
        }
        if data
          if method==:get || method==:delete
            request[:headers][:params] = data
          else
            request[:payload] = data.is_a?(String) ? data : data.to_json
          end
        end

        response = begin
          RestClient::Request.execute(request)
        rescue RestClient::ExceptionWithResponse => ex
          ex.response
        end

        if @debug
          puts "[DEBUG] [REQUEST:METHOD]  #{request[:method].to_s.upcase} #{request[:url]}"
          puts "[DEBUG] [REQUEST:HEADERS] #{request[:headers]}"
          puts "[DEBUG] [REQUEST:PAYLOAD] #{data}"
          puts "[DEBUG] [RESPONSE:CODE]   #{response.code}" 
          puts "[DEBUG] [RESPONSE:BODY]   #{response.body}" 
        end

        TerraformEnterprise::API::Response.new(response)
      end

      private

      def uri(path=[])
        return path if path.is_a?(String) && path.start_with?("http")
        "#{@base}/#{path.map{|p| p.to_s}.join('/')}"
      end
    end
  end
end