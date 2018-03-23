module TerraformEnterprise  
  class ResourcesClient
    def initialize(client, params={})
      @client = client
      @params = params
    end
  end
end