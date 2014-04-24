# module CliftonSchema
class ViewTableField
  attr_reader :name

  def initialize(&block)
    @name = nil
    instance_eval(&block) unless block.nil?

    self
  end
end
# end