require 'json'
require 'rest-client'

require 'terraform_enterprise_api/resources/configuration-versions'
require 'terraform_enterprise_api/resources/linkable-repos'
require 'terraform_enterprise_api/resources/organizations'
require 'terraform_enterprise_api/resources/policies'
require 'terraform_enterprise_api/resources/runs'
require 'terraform_enterprise_api/resources/workspaces'

module TerraformEnterprise
  class Client
    attr_accessor :base

    def initialize(api_key:, host: 'https://atlas.hashicorp.com/api/v2')
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

    def policies
      TerraformEnterprise::Policies.new(self)
    end

    def linkable_repos
      TerraformEnterprise::LinkableRepos.new(self)
    end

    def configuration_versions
      TerraformEnterprise::ConfigurationVersions.new(self)
    end

    def runs
      TerraformEnterprise::Runs.new(self)
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
      # if method==:get || method==:delete || (request[:headers]['Content-Type'] != 'application/vnd.api+json' && request[:headers]['Content-Type'] != 'application/json')
      if method==:get || method==:delete
        request[:headers][:params] = data
      else
        request[:payload] = data.is_a?(String) ? data : data.to_json
      end
      puts request if ENV['DEBUG']
      response = RestClient::Request.execute(request)
      puts response if ENV['DEBUG']
      if response.headers[:content_type] && response.headers[:content_type].include?('json')
        parsed_data = JSON.parse(response) || {}
        return_data = parsed_data['data']
      else
        return_data = response.body
      end
      return_data
    rescue => ex
      raise ArgumentError, "#{ex.message}: #{request}"
    end

    private

    def uri(path=[])
      return path if path.is_a?(String) && path.start_with?("http")
      "#{@base}/#{path.map{|p| p.to_s}.join('/')}"
    end
  end
end