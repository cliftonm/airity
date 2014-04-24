class PresentationMetadata
  attr_reader :field
  attr_reader :control
  attr_reader :label
  attr_reader :url
  attr_reader :value

  attr_reader :inline
  attr_reader :columns

  attr_reader :classes

  def initialize(&block)
    @inline = false
    @classes = ''
    instance_eval(&block) unless block.nil?
  end
end