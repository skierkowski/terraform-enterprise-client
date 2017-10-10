require "terraform_enterprise_api/resources_client"

module TerraformEnterprise  
  class Policies < ResourcesClient
    def list(params={})
      org = params[:organization]
      @client.get(:organizations, org, :policies)
    end

    def get(params={})
      org = params[:organization]
      id  = params[:workspace]
      @client.get(:organizations, org, :policies, id)
    end
  end
end