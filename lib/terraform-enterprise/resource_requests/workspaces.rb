require "terraform-enterprise/client/resource_request"

module TerraformEnterprise  
  module API
    class Workspaces < TerraformEnterprise::API::ResourceRequest
      def list(params={})
        @request.get(:organizations, params[:organization], :workspaces)
      end

      def get(params={})
        @request.get(:organizations, params[:organization], :workspaces, params[:workspace])
      end

      def create(params={})
        org = params.delete(:organization)
        data = {
          attributes: params,
          type: 'workspaces'
        }

        @request.post(:organizations, org, :workspaces, data: data)
      end

      def update(params={})
        org = params.delete(:organization)
        id  = params.delete(:workspace)

        data = {
          attributes: params,
          type: 'workspaces'
        }

        @request.patch(:organizations, org, :workspaces, id, data: data)
      end

      def delete(params={})
        @request.delete(:organizations, params[:organization], :workspaces, params[:workspace])
      end

      def action(params={})
        @request.post(:workspaces, params[:id], :actions, params[:action].to_sym)
      end
    end
  end
end