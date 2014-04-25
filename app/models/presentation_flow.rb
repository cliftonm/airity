class PresentationFlow
  attr_reader :width
  attr_reader :classes
  attr_reader :label_classes
  attr_reader :label_columns
  attr_reader :field_columns
  attr_reader :fields

  def initialize(&block)
    @fields = []
    instance_eval(&block) unless block.nil?
  end

  def add_field(field)
    @fields << field
  end
end