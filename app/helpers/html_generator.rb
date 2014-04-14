require 'clifton_lib/xml/xml_document'
include CliftonXml

module Airity
  class HtmlGenerator
    attr_accessor :str
    attr_reader :xdoc

    def initialize()
      @xdoc = XmlDocument.new()
      @current_node = @xdoc
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

    # This must always be the starting
    def body()
      element = @xdoc.create_element('body')
      @current_node.append_child(element)
      @current_node = element

      nil
    end

    def body_end()
      pop()
      nil
    end

    def form_for(model_name)
      element = @xdoc.create_element('form')
      @current_node.append_child(element)
      element.append_attribute(@xdoc.create_attribute('id', 'new_'+model_name))
      element.append_attribute(@xdoc.create_attribute('action', '/'+model_name))
      element.append_attribute(@xdoc.create_attribute('class', 'new_'+model_name))
      element.append_attribute(@xdoc.create_attribute('method', 'post'))
      @current_node = element

      nil
    end

    def form_end()
      pop()
      nil
    end

    def div(id = nil, style = nil)
      element = @xdoc.create_element('div')
      @current_node.append_child(element)
      element.append_attribute(@xdoc.create_attribute('id', id)) if id
      element.append_attribute(@xdoc.create_attribute('class', style)) if style
      @current_node = element

      nil
    end

    def div_end()
      pop()
      nil
    end

    def line_break()
      element = @xdoc.create_element('br')
      @current_node.append_child(element)

      nil
    end

    def label(text, field_name = nil, id = nil, style = nil)
      element = @xdoc.create_element('label')
      @current_node.append_child(element)

      # TODO: throw exception if both field_name and id are specified
      element.append_attribute(@xdoc.create_attribute('id', 'lbl_' + field_name)) if field_name
      element.append_attribute(@xdoc.create_attribute('id', id)) if id

      element.append_attribute(@xdoc.create_attribute('class', style)) if style
      element.inner_text = text

      nil
    end

    def text_field(model_name, field_name = nil, id = nil, style = nil)
      element = @xdoc.create_element('input')
      @current_node.append_child(element)

      # TODO: throw exception if both field_name and id are specified
      element.append_attribute(@xdoc.create_attribute('id', model_name + '_' + field_name)) if field_name
      element.append_attribute(@xdoc.create_attribute('id', id)) if id

      element.append_attribute(@xdoc.create_attribute('name', model_name + bracket(field_name))) if field_name

      element.append_attribute(@xdoc.create_attribute('class', style)) if style
      element.append_attribute(@xdoc.create_attribute('type', 'text'))

      nil
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

    private

    def pop()
      @current_node = @current_node.parent_node

      nil
    end
  end
end

