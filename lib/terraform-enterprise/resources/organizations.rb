require "terraform-enterprise/resources_client"

module TerraformEnterprise  
  class Organizations < ResourcesClient
    def list(params={})
      @request.get(:organizations)
    end

    def get(params={})
      @request.get(:organizations, params[:name])
    end

    def create(params={})
      data = {
        attributes: params,
        type: 'organizations'
      }

      @request.post(:organizations, data: data)
    end

    def delete(params={})
      @request.delete(:organizations, params[:name])
    end
  end
end