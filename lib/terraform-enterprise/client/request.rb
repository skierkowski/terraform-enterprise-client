require 'terraform-enterprise/client/response'

module TerraformEnterprise
  module API
    # A wrapper for HTTP JSON-API requests to provide convenience request
    # method wrappers.
    class Request
      attr_accessor :base
      DEFAULT_DEBUG = false
      DEFAULT_HOST = 'https://app.terraform.io/api/v2'.freeze

      def initialize(options = {})
        @base    = options[:host] || DEFAULT_HOST
        @api_key = options[:api_key]
        @debug   = options[:debug] || DEFAULT_DEBUG
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
        request(:delete, path, data)
      end

      def post(*path)
        data = path.pop if path.last.is_a?(Hash)
        request(:post, path, data)
      end

      def put(*path)
        data = path.pop if path.last.is_a?(Hash)
        request(:put, data, data)
      end

      def patch(*path)
        data = path.pop if path.last.is_a?(Hash)
        request(:patch, path, data)
      end

      def request(method, path, data = {}, headers = {})
        request_options = define_request(method, path, data, headers)
        response        = execute(request_options)
        debug(request_options, response, data) if @debug
        TerraformEnterprise::API::Response.new(response)
      end

      private

      def define_request(method, path, data = {}, headers = {})
        request_options = {
          method:  method,
          url:     uri(path),
          headers: @headers.merge(headers || {})
        }
        if %i[get delete].include?(method)
          request_options[:headers][:params] = data
        else
          request_options[:payload] = data.is_a?(String) ? data : data.to_json
        end
        request_options
      end

      def execute(request)
        RestClient::Request.execute(request)
      rescue RestClient::ExceptionWithResponse => ex
        ex.response
      end

      def debug(http_request, http_response, data)
        http_method = http_request[:method].to_s.upcase
        puts "[DEBUG] [REQUEST:METHOD]  #{http_method} #{http_request[:url]}"
        puts "[DEBUG] [REQUEST:HEADERS] #{http_request[:headers]}"
        puts "[DEBUG] [REQUEST:PAYLOAD] #{data}"
        puts "[DEBUG] [RESPONSE:CODE]   #{http_response.code}"
        puts "[DEBUG] [RESPONSE:BODY]   #{http_response.body}"
      end

      def uri(path = [])
        return path if path.is_a?(String) && path.start_with?('http')
        "#{@base}/#{path.map(&:to_s).join('/')}"
      end
    end
  end
end
