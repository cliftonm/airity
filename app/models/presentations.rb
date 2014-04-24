class Presentations
  attr_reader :presentations

  def initialize()
    @presentations = []
  end

  def [](name)
    @presentations.find {|p| p.name == name}
  end

  def add_presentation(presentation)
    @presentations << presentation
  end
end