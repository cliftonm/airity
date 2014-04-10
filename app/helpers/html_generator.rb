require 'element'
include Airity

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

    def leading_underscore(str)
      '_' << str
    end

    def bracket(str)
      '[' << str << ']'
    end

    def tag_end(tag)
      @indent = @indent - 2
      str = indentation() << Element.close(tag)
      str << @crlf
      str
    end

    def form_for(model_name)
      str = @crlf + indentation()
      str << Element.new('form').
          attribute('id', 'new_', model_name).
          attribute('action', '/', model_name).
          attribute('class', 'new_', model_name).
          attribute('method', 'post').to_string()
      str << @crlf
      @indent = @indent + 2
      str
    end

    def label(field, text, style = '')
      str = indentation()
      str << Element.new('label').
          attribute('id', 'lbl_', field).
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
          attribute('id', model_name, leading_underscore(field)).
          attribute('name', model_name + bracket(field)).
          attribute('type', 'text').
          close().to_string()
      str << @crlf
      str
    end

    def post_button(label, style = '')
      str = indentation()
      str << Element.new('input').
          conditional_attribute('class', style).
          attribute('id', model_name, '_commit').
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

    def link_to(text, path, id = '', style = '')
      str = indentation()
      str << Element.new('a').
          conditional_attribute('id', id).
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
          attribute('href', 'mailto:', url).
          inner_xml(text).
          close().to_string()
      str << @crlf
      str
    end

    def form_end()
      tag_end('form')
    end

    def div_start(id = '', style = '')
      str = indentation()
      str << Element.new('div').
          conditional_attribute('id', id).
          conditional_attribute('class', style).to_string()
      str << @crlf
      @indent = @indent + 2
      str
    end

    def div_end()
      tag_end('div')
    end

    def nav(style = '', data = '')
      str = indentation()
      str << Element.new('nav').
        conditional_attribute('class', style).
        data_attribute(data).
        to_string()
      str << @crlf
      @indent = @indent + 2
      str
    end

    def nav_end
      tag_end('nav')
    end
  end

  def ul(style = '')
    str = indentation()
    str << Element.new('ul').
        conditional_attribute('class', style).
        to_string()
    str << @crlf
    @indent = @indent + 2
    str
  end

  def ul_end()
    tag_end('ul')
  end

  def li(id = '', text = '', style = '')
    str = indentation()
    str << Element.new('li').
        conditional_attribute('id', id).
        conditional_attribute('class', style).
        conditional_inner_xml(text).
        conditional_close().
        to_string()
    str << @crlf

    if text.blank?
      @indent = @indent + 2
    end

    str
  end

  def li_end()
    tag_end('li')
  end

  def section(style = '')
    str = indentation()
    str << Element.new('section').
        conditional_attribute('class', style).
        to_string()
    str << @crlf
    @indent = @indent + 2
    str
  end

  def section_end()
    tag_end('section')
  end

  def header(header_num)
    str = indentation()
    str << Element.new('h' + header_num.to_s).
        to_string()
    str << @crlf
    @indent = @indent + 2
    str
  end

  def header_end(header_num)
    tag_end('h' + header_num.to_s)
  end
end

