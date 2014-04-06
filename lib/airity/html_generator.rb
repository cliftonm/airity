module Airity
  class HtmlGenerator
    attr_accessor :str

    def initialize()
      @indent = 0
      @crlf = "\r\n"
    end

    def indentation()
      ' ' * @indent
    end

    def form_for(model_name)
      str = @crlf + indentation()
      str << Element.new('form').
          attribute('action', '/'+model_name).
          attribute('class', 'new_'+model_name).
          attribute('id', 'new_'+model_name).
          attribute('method', 'post').to_string()
      str << @crlf
      @indent = @indent + 2
      str
    end

    def label(field, text, style = '')
      str = indentation()
      str << Element.new('label').
          conditional_attribute('class', style).
          attribute('for', field).
          inner_xml(text).
          close().to_string()
      str << @crlf
      str
    end

    def p(text, style = '')
      str = indentation()
      str << Element.new('p').
          conditional_attribute('class', style).
          inner_xml(text).
          close().to_string()
      str << @crlf
      str
    end

    def text_field(model_name, field, style = '')
      str = indentation()
      str << Element.new('input').
          conditional_attribute('class', style).
          attribute('id', model_name + '_' + field).
          attribute('name', model_name + '[' + field +']').
          attribute('type', 'text').
          close().to_string()
      str << @crlf
      str
    end

    def post_button(label, style = '')
      str = indentation()
      str << Element.new('input').
          conditional_attribute('class', style).
          attribute('name', 'commit').
          attribute('type', 'submit').
          attribute('value', label).
          close().to_string()
      str << @crlf
      str
    end

    def image(image_name, style = '')
      str = indentation()
      str << Element.new('img').
          conditional_attribute('class', style).
          attribute('src', image_name).
          close().to_string()
      str << @crlf
      str
    end

    def link_to(text, path, style = '')
      str = indentation()
      str << Element.new('a').
          conditional_attribute('class', style).
          attribute('href', path).
          inner_xml(text).
          close().to_string()
      str << @crlf
      str
    end

    def email(text, url, style = '')
      str = indentation()
      str << Element.new('a').
          conditional_attribute('class', style).
          attribute('href', 'mailto:' + url).
          inner_xml(text).
          close().to_string()
      str << @crlf
      str
    end

    def form_end()
      @indent = @indent - 2
      str = indentation() << Element.close('form')
      str << @crlf
      str
    end

    def div_start(style = '')
      str = indentation()
      str << Element.new('div').
          conditional_attribute('class', style).to_string()
      str << @crlf
      @indent = @indent + 2
      str
    end

    def div_end()
      @indent = @indent - 2
      str = indentation() << Element.close('div')
      str << @crlf
      str
    end

    def row_start(style = '')
      str = indentation()
      str << Element.new('div').
          attribute('class', 'row ' + style).
          to_string()
      str << @crlf
      @indent = @indent + 2
      str
    end

    def row_end()
      div_end()
    end

    def columns_start(num_cols, style = '')
      str = indentation()
      str << Element.new('div').
          attribute('class', 'small-'+num_cols.to_s+' columns ' + style).
          to_string()
      str << @crlf
      @indent = @indent + 2
      str
    end

    def columns_end()
      div_end()
    end

  end
end