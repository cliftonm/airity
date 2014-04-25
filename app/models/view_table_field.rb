# module CliftonSchema
class ViewTableField
  attr_reader :table_field

  def initialize(&block)
    instance_eval(&block) unless block.nil?

    self
  end
end
# end