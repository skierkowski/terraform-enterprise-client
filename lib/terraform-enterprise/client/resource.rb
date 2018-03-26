module TerraformEnterprise
  module API
    class Resource
      attr_accessor :type, :attributes, :id, :relationships, :links, :errors, :success
      def initialize(data)
        @id               = data['id']
        @type             = data['type']
        @attributes       = data['attributes'] || {}
        @relationships    = data['relationships'] || {}
        @links            = data['links'] || []
        @errors           = data['errors'] || []
      end

      def has_errors?
        !@errors.empty?
      end
    end
  end
end