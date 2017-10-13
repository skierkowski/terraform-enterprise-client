require "terraform_enterprise_api/resources_client"

module TerraformEnterprise  
  class Workspaces < ResourcesClient
    def list(params={})
      org = params[:organization]
      @client.get(:organizations, org, :workspaces)
    end

    def get(params={})
      org = params[:organization]
      id  = params[:workspace]
      @client.get(:organizations, org, :workspaces, id)
    end

    def create(params={})
      data = {
        attributes: params,
        type: 'compound-workspaces'
      }

      @client.post('compound-workspaces', data: data)
    end

    def update(params={})
      org = params.delete(:organization)
      id  = params.delete(:workspace)

      data = {
        attributes: params,
        type: 'compound-workspaces'
      }

      @client.patch('compound-workspaces', id, data: data)
    end
  end
end