# Intended to work closely with Foundation
class Presentation
  attr_reader :name
  attr_reader :view_name
  attr_reader :columns
  attr_reader :classes
  attr_reader :label_classes
  attr_reader :label_columns
  attr_reader :field_columns
  attr_reader :metadata

  def initialize(&block)
    @metadata = []
    instance_eval(&block) unless block.nil?
  end

  def add_metadata(metadata)
    @metadata << metadata
  end
end