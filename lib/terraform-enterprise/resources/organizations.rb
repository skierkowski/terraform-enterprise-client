require "terraform-enterprise/resources_client"

module TerraformEnterprise  
  class Organizations < ResourcesClient
    def list(params={})
      @client.get(:organizations)
    end

    def get(params={})
      @client.get(:organizations, params[:name])
    end

    def create(params={})
      data = {
        attributes: params,
        type: 'organizations'
      }

      @client.post(:organizations, data: data)
    end

    def delete(params={})
      @client.delete(:organizations, params[:name])
    end
  end
end