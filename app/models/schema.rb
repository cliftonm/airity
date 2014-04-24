# module CliftonSchema
  class Schema
    attr_reader :tables
    attr_reader :views

    def initialize
      @tables = []
      @views = []
    end

    def add_table(table)
      @tables << table
    end

    def add_view(view)
      @views << view
    end
  end
# end