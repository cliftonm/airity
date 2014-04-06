module Airity
  # Manages a collection of CSS style attributes for a specific style.
  # Example usage:

=begin
    label_style = Style.new {
      @style_name = 'label-style'
      @styles =
          {
            font_size: '12px',
            margin_top: '4px'
          }
    }
=end

  class Style
    attr_accessor :style_name               # the style name
    attr_accessor :styles                   # the array of style attribute => value hashes
    attr_accessor :css                      # the computed css

    # The block is used to initialize the attributes.  See example above.
    def initialize(&block)
      instance_eval(&block)
      @css = get_css()                      # Compute immediately so we're not wasting time during page generation.
    end

    def get_css()
      str = '  .' << @style_name << '{'

      # key-value pair of the style.
      styles.each{|k, v|
        # replace underscore with '-' for attribute names since that's the convention used by css attributes.
        style_name = k.to_s.gsub('_', '-')
        str << style_name << ':' << v << ';'
      }

      str << '}'
      str
    end
  end
end
