require "terraform_enterprise_api/resources_client"

module TerraformEnterprise  
  class Runs < ResourcesClient

    def create(params={})
      workspace             = params.delete(:workspace)
      configuration_version = params.delete(:configuration_version)


      data = {
        attributes: params,
        type: 'runs',
        relationships: {
          workspace: {
            data: {
              type: 'workspaces',
              id: workspace
            }
          }
        }
      }

      if configuration_version
        data[:relationships]['configuration-versions'] = {
          data: {
            type:'configuration-versions',
            id: configuration_version
          }
        }
      end 

      @client.post(:runs, {data: data})
    end

  end
end