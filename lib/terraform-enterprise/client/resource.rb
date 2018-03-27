module TerraformEnterprise
  module API
    # A class wrapper for JSON-API resources
    class Resource
      attr_accessor :type, :attributes, :id, :relationships, :links, :errors
      def initialize(data)
        @id            = data['id']
        @type          = data['type']
        @attributes    = data['attributes'] || {}
        @relationships = data['relationships'] || {}
        @links         = data['links'] || []
        @errors        = data['errors'] || []
      end

      def errors?
        !@errors.empty?
      end
    end
  end
end
