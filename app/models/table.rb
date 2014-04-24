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

    def add_field(field)
      @fields << field
    end
  end
# end