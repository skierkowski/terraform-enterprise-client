require 'terraform_enterprise/api/resource_request'

module TerraformEnterprise
  module API
    # Organization resource request
    class Organizations < TerraformEnterprise::API::ResourceRequest
      def list
        @request.get(:organizations)
      end

      def get(params = {})
        @request.get(:organizations, params[:name])
      end

      def create(params = {})
        data = {
          attributes: params,
          type: 'organizations'
        }

        @request.post(:organizations, data: data)
      end

      def delete(params = {})
        @request.delete(:organizations, params[:name])
      end
    end
  end
end
