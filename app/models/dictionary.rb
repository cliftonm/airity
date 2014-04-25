class Dictionary
  attr_reader :definitions

  def initialize(&block)
    @definitions = []
    instance_eval(&block) unless block.nil?

    self
  end

  def [](name)
    @definitions.find {|p| p.name == name}
  end

  def add_definition(definition)
    @definitions << definition

    nil
  end
end