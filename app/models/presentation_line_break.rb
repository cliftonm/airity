class PresentationLineBreak < PresentationField
  def initialize(&block)
    super()
    instance_eval(&block) unless block.nil?
  end
end
