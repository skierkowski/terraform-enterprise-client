module TerraformEnterprise
  module API
    # Class is used to get access to the request and parameters for each
    # resource request from the client
    class ResourceRequest
      def initialize(request, params = {})
        @request = request
        @params  = params
      end
    end
  end
end
