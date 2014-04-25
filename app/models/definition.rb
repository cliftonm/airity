class Definition
  attr_reader :name
  attr_reader :type
  attr_reader :control
  attr_reader :label

  def initialize(&block)
    instance_eval(&block) unless block.nil?

    self
  end
end