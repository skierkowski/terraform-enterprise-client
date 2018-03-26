module TerraformEnterprise
  module API
    class ResourceRequest
      def initialize(request, params={})
        @request = request
        @params  = params
      end
    end
  end
end