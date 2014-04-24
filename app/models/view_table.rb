# module CliftonSchema
class ViewTable
  attr_reader :name
  attr_reader :view_table_fields

  def initialize(&block)
    @name = nil
    @view_table_fields = []
    instance_eval(&block) unless block.nil?

    self
  end

  def add_view_table_field(field)
    @view_table_fields << field
  end
end
# end