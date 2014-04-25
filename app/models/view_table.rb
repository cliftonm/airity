# module CliftonSchema
class ViewTable
  attr_reader :table
  attr_reader :view_table_fields

  def initialize(&block)
    @view_table_fields = []
    instance_eval(&block) unless block.nil?

    self
  end

  def add_view_table_field(table_field)
    @view_table_fields << table_field
  end
end
# end