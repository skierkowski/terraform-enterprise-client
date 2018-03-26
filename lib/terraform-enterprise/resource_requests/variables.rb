require "terraform-enterprise/client/resource_request"

module TerraformEnterprise  
  module API
    class Variables < TerraformEnterprise::API::ResourceRequest
      
      def list(params={})
        filter = {}
        filter[:workspace] = {name: params[:workspace]} if params[:workspace]
        filter[:organization] = {name: params[:organization]} if params[:organization]
        @request.get(:vars, {filter:filter})
      end

      def get(params={})
        @request.get(:vars, params[:id])
      end

      def create(params={})
        org = params.delete(:organization)
        workspace = params.delete(:workspace)
        data = {
          attributes: params,
          type: 'vars',
        }
        filter = {
          organization: {name: org},
          workspace: {name: workspace}
        }

        @request.post(:vars, {data: data, filter: filter})
      end

      def update(params={})
        id = params.delete(:id)
        data = {
          attributes: params,
          type: 'vars',
        }

        @request.patch(:vars, id, data: data)
      end

      def delete(params={})
        @request.delete(:vars, params[:id])
      end
    end
  end
end