# Intended to work closely with Foundation
class Presentation
  attr_reader :name
  attr_reader :view_name
  attr_reader :width
  attr_reader :classes
  attr_reader :flows

  def initialize(&block)
    @flows = []
    instance_eval(&block) unless block.nil?
  end

  def add_flow(flow)
    @flows << flow
  end
end

