# module CliftonSchema
class View
  attr_reader :name
  attr_reader :view_tables
  attr_reader :view_fields

  def initialize(&block)
    @name = nil
    @view_tables = []
    @view_fields = []
    instance_eval(&block) unless block.nil?

    self
  end

  def add_view_table(view_table)
    @view_tables << view_table
  end

  def add_view_field(field)
    @view_fields << field
  end
end
# end