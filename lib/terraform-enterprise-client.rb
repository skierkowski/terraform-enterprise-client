require 'json'
require 'rest-client'

require 'terraform-enterprise/resources/organizations'
require 'terraform-enterprise/resources/oauth-tokens'
require 'terraform-enterprise/resources/workspaces'

module TerraformEnterprise
  class Client
    attr_accessor :base

    def initialize(api_key:, host: 'https://app.terraform.io/api/v2')
      @base    = host
      @api_key = api_key
      @headers = {
        'Authorization' => "Bearer #{@api_key}",
        'Content-Type' => 'application/vnd.api+json'
      }
    end

    def workspaces
      TerraformEnterprise::Workspaces.new(self)
    end

    def organizations
      TerraformEnterprise::Organizations.new(self)
    end

    def oauth_tokens
      TerraformEnterprise::OAuthTokens.new(self)
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

      if response.headers[:content_type] && response.headers[:content_type].include?('json')
        return_data = JSON.parse(response) || {}
      else
        return_data = response.body
      end
      {'code' => response.code, 'body' => return_data}
    end

    private

    def uri(path=[])
      return path if path.is_a?(String) && path.start_with?("http")
      "#{@base}/#{path.map{|p| p.to_s}.join('/')}"
    end
  end
end