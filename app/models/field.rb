# module CliftonSchema
  class Field
    attr_reader :name
    attr_reader :type
    attr_reader :allow_null

    def initialize(&block)
      @name = nil

      # defaults
      @type = 'string'
      @allow_null = false

      instance_eval(&block) unless block.nil?

      self
    end
  end
# end