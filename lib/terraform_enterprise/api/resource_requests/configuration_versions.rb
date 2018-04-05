require 'terraform_enterprise/api/resource_request'

module TerraformEnterprise
  module API
    # Variables resource request
    class ConfigurationVersions < TerraformEnterprise::API::ResourceRequest
      def list(params = {})
        @request.get(:workspaces, params[:workspace], 'configuration-versions')
      end

      def get(params = {})
        @request.get('configuration-versions', params[:id])
      end

      def create(params = {})
        data = {
          type: 'configuration-versions'
        }
        @request.post(:workspaces, params[:workspace], 'configuration-versions', data: data)
      end

      def upload(params = {})
        headers = { 'Content-Type' => 'application/octet-stream' }
        @request.request(:put, params[:url], params[:content], headers)
      end
    end
  end
end
