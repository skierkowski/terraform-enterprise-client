require "terraform_enterprise_api/resources_client"

module TerraformEnterprise  
  class ConfigurationVersions < ResourcesClient
    TYPE = 'configuration-version'
    
    def list(params={})
      org = params[:organization]
      workspace  = params[:workspace]

      @client.get('configuration-versions', filter:{organization:{username:org}, workspace:{name:workspace}})
    end

    def get(params={})
      id  = params[:configuration_version]
      @client.get('configuration-versions', id)
    end

    def get_latest(params={})
      org = params[:organization]
      id  = params[:workspace]

      workspace     = @client.get(:organizations, org, :workspaces, id)
      latest_run_id = workspace['relationships']['latest-run']['data']['id']
      latest_run    = @client.get(:runs, latest_run_id, include:'configuration-version')
      latest_run['relationships']['configuration-version']['data']
      @client.get('configuration-versions', latest_run['relationships']['configuration-version']['data']['id'])
    end

    def create(params={})
      workspace = params.delete(:workspace)

      data = { data: { type: TYPE } }
      data[:data][:attributes] = params if params.length > 0
      @client.post(:workspaces, workspace, 'configuration-versions', data)
    end

    def upload(params={})
      id         = params[:configuration_version]
      content    = params[:content]
      upload_url = params[:upload_url]
      headers = {
        "Content-Type" => "application/octet-stream",
      }
      @client.request(:put, upload_url, content, headers)
    end
  end
end