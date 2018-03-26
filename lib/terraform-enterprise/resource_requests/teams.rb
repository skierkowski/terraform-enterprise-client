require "terraform-enterprise/client/resource_request"

module TerraformEnterprise  
  module API
    class Teams < TerraformEnterprise::API::ResourceRequest
      
      def list(params={})
        @request.get(:organizations, params[:organization], :teams)
      end

      def get(params={})
        @request.get(:teams, params[:id])
      end

      def create(params={})
        org = params.delete(:organization)
        data = {
          attributes: params,
          type: 'teams'
        }

        @request.post(:organizations, org, :teams, data: data)
      end

      def delete(params={})
        @request.delete(:teams, params[:id])
      end
    end
  end
end