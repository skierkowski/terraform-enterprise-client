module TerraformEnterprise  
  class Resource
    attr_accessor :id_attribute

    def initialize(data:{}, client:)
      @data         = data
      @id_attribute = 'id'
      @client       = client
    end

    def id
      @data[id_attribute]
    end

    def attributes
      @data['attributes']
    end

    def type
      @data['type']
    end

    def to_s
      @data.to_s
    end
  end
end