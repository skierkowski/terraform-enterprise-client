require "terraform_enterprise_api/resources_client"

module TerraformEnterprise  
  class Policies < ResourcesClient
    def list(params={})
      org = params[:organization]
      @client.get(:organizations, org, :policies)
    end

    def get(params={})
      org = params[:organization]
      id  = params[:policy]
      @client.get(:organizations, org, :policies, id)
    end

    def create(params={})
      org = params.delete(:organization)

      data = {
        attributes: params,
        type: 'policies'
      }

      @client.post(:organizations, org, :policies, {data: data})
    end

    def delete(params={})
      id  = params[:policy]
      @client.delete(:policies, id)
    end

    def download(params={})
      id = params[:policy]
      @client.get(:policies, id, :download)
    end

    def upload(params={})
      id      = params[:policy]
      content = params[:content]
      headers = {
        'Content-Type' => 'application/octet-stream'
      }
      @client.request(:put, [:policies, id, :upload],content, headers)
    end
  end
end