class PresentationLinkTo < PresentationField
  attr_reader :label
  attr_reader :url

  def initialize(&block)
    super()
    instance_eval(&block) unless block.nil?
  end
end
