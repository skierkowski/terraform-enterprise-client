require 'terraform_enterprise/api/resource_request'

module TerraformEnterprise
  module API
    # Workspace resource request
    class Workspaces < TerraformEnterprise::API::ResourceRequest
      def list(params = {})
        @request.get(:organizations, params[:organization], :workspaces)
      end

      def get(params = {})
        organization = params[:organization]
        workspace    = params[:workspace]
        @request.get(:organizations, organization, :workspaces, workspace)
      end

      def create(params = {})
        org = params.delete(:organization)
        data = {
          attributes: params,
          type: 'workspaces'
        }

        @request.post(:organizations, org, :workspaces, data: data)
      end

      def update(params = {})
        org = params.delete(:organization)
        id  = params.delete(:workspace)

        data = {
          attributes: params,
          type: 'workspaces'
        }

        @request.patch(:organizations, org, :workspaces, id, data: data)
      end

      def delete(params = {})
        organization = params[:organization]
        workspace    = params[:workspace]
        @request.delete(:organizations, organization, :workspaces, workspace)
      end

      def action(params = {})
        id     = params[:id]
        action = params[:action].to_sym
        @request.post(:workspaces, id, :actions, action)
      end
    end
  end
end
