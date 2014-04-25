# module CliftonSchema
  class Table
    attr_reader :name
    attr_reader :fields

    def initialize(&block)
      @name = nil
      @fields = []
      instance_eval(&block) unless block.nil?

      self
    end

    def [](name)
      @fields.find {|p| p.definition.name == name}
    end

    def add_field(field)
      @fields << field

      nil
    end
  end
# end