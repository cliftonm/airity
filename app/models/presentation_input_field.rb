class PresentationInputField < PresentationField
  attr_reader :value

  def initialize(&block)
    super()
    instance_eval(&block) unless block.nil?
  end
end

