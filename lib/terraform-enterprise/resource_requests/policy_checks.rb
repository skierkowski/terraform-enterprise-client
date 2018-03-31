require 'terraform-enterprise/client/resource_request'

module TerraformEnterprise
  module API
    # Policy Checks resource request
    class PolicyChecks < TerraformEnterprise::API::ResourceRequest
      def list(params = {})
        @request.get(:runs, params[:run_id], 'policy-checks')
      end

      def action(params = {})
        id     = params.delete(:id)
        action = params.delete(:action).to_sym
        @request.post('policy-checks', id, :actions, action, params)
      end
    end
  end
end
