require 'terraform_enterprise/api/resource_request'

module TerraformEnterprise
  module API
    # Teams resource request
    class Policies < TerraformEnterprise::API::ResourceRequest
      def list(params = {})
        @request.get(:organizations, params[:organization], :policies)
      end

      def get(params = {})
        @request.get(:policies, params[:id])
      end

      def create(params = {})
        org = params.delete(:organization)
        data = {
          attributes: params,
          type: 'policies'
        }

        @request.post(:organizations, org, :policies, data: data)
      end

      def update(params = {})
        id = params.delete(:id)
        data = {
          attributes: params,
          type: 'policies'
        }

        @request.patch(:policies, id, data: data)
      end

      def upload(params = {})
        headers = { 'Content-Type' => 'application/octet-stream' }
        path    = [:policies, params[:id], :upload]
        @request.request(:put, path, params[:content], headers)
      end

      def delete(params = {})
        @request.delete(:policies, params[:id])
      end
    end
  end
end
