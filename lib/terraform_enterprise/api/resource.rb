module TerraformEnterprise
  module API
    # A class wrapper for JSON-API resources
    class Resource
      attr_reader :body

      def initialize(body)
        @body = body || {}
      end

      def errors?
        !errors.empty?
      end

      def data
        @body['data'] || {}
      end

      def id
        data['id']
      end

      def type
        data['type']
      end

      def attributes
        data['attributes'] || {}
      end

      def relationships
        data['relationships'] || {}
      end

      def links
        data['links'] || []
      end

      def errors
        data['errors'] || []
      end

      def included
        (body['included'] || []).map{ |resource| Resource.new('data' => resource)}
      end
    end
  end
end
