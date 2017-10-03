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
  end
end