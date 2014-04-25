# module CliftonSchema
class ViewField
  attr_reader :definition
  attr_reader :allow_null

  def initialize(&block)
    @allow_null = false

    instance_eval(&block) unless block.nil?

    self
  end
end
# end