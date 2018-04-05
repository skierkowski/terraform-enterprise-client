require 'terraform_enterprise/api/resource_request'

module TerraformEnterprise
  module API
    # Variables resource request
    class Runs < TerraformEnterprise::API::ResourceRequest
      

      def list(params = {})
        @request.get(:workspaces, params[:id], :runs)
      end

      def create(params = {})
        data = {
          attributes: {
            'is-destroy' => params[:destroy] || false
          },
          relationships: {
            workspace: {
              data: {
                type: 'workspaces',
                id: params[:workspace_id]
              }
            }
          },
          type: 'runs'
        }

        if params[:configuration_version_id]
          data[:relationships]['configuration-version'] = {
            data: {
              type: 'configuration-version',
              id: params[:configuration_version_id]
            }
          }
        end

        @request.post(:runs, data: data)
      end

      def get(params = {})
        id = params.delete(:id)
        @request.get(:runs, id, params)
      end

      def action(params = {})
        id     = params.delete(:id)
        action = params.delete(:action).to_sym
        @request.post(:runs, id, :actions, action, params)
      end
    end
  end
end
