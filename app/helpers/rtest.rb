class DoStuff
  attr_reader :accum

  def initialize
    @accum = ''
  end

  def do_a(&block)
    @accum << 'a'
    @accum << yield
  end

  def do_b(&block)
    @accum << 'b'
    @accum << yield
  end
end

def fubar
  do_stuff = DoStuff.new

  do_stuff.do_a do
    do_stuff.do_b do
      "rec\r\n"
    end
    ''
  end

  puts (do_stuff.accum)
end

fubar