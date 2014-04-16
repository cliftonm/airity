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

    # This must always be the starting
    def body(id = nil, style = nil)
      element = @xdoc.create_element('body')
      @current_node.append_child(element)
      element.append_attribute(@xdoc.create_attribute('id', id)) if id
      element.append_attribute(@xdoc.create_attribute('class', style)) if style
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

    # void nav(string id = nil, Hash style = nil, string[] data = nil)
    def nav(id = nil, style = nil, data = nil)
      element = @xdoc.create_element('nav')
      @current_node.append_child(element)
      element.append_attribute(@xdoc.create_attribute('id', id)) if id
      element.append_attribute(@xdoc.create_attribute('class', style)) if style

      # special case:
      # example: <nav class="top-bar" data-topbar>
      if data
        data.each {|item|
          item = item.gsub('_', '-')
          element.append_attribute(@xdoc.create_attribute(item, nil))
        }
      end

      @current_node = element

      nil
    end

    def nav_end
      pop()
      nil
    end

    def ul(id = nil, style = nil)
      element = @xdoc.create_element('ul')
      @current_node.append_child(element)
      element.append_attribute(@xdoc.create_attribute('id', id)) if id
      element.append_attribute(@xdoc.create_attribute('class', style)) if style
      @current_node = element

      nil
    end

    def ul_end()
      pop()
      nil
    end

    def li(text = nil, id = nil, style = nil)
      element = @xdoc.create_element('li')
      @current_node.append_child(element)
      element.append_attribute(@xdoc.create_attribute('id', id)) if id
      element.append_attribute(@xdoc.create_attribute('class', style)) if style
      element.inner_text = text if text
      @current_node = element

      nil
    end

    def li_end()
      pop()
      nil
    end

    def section(id = nil, style = nil)
      element = @xdoc.create_element('section')
      @current_node.append_child(element)
      element.append_attribute(@xdoc.create_attribute('id', id)) if id
      element.append_attribute(@xdoc.create_attribute('class', style)) if style
      @current_node = element

      nil
    end

    def section_end()
      pop()
      nil
    end

    def header(header_num = 1, id = nil, style = nil)
      element = @xdoc.create_element('h' + header_num.to_s)
      @current_node.append_child(element)
      element.append_attribute(@xdoc.create_attribute('id', id)) if id
      element.append_attribute(@xdoc.create_attribute('class', style)) if style
      @current_node = element

      nil
    end

    def header_end()
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

    def p(text, id = nil, style = nil)
      element = @xdoc.create_element('p')
      @current_node.append_child(element)
      element.append_attribute(@xdoc.create_attribute('id', id)) if id
      element.append_attribute(@xdoc.create_attribute('class', style)) if style
      element.inner_text = text

      nil
    end

    def post_button(label, id = nil, style = nil)
      element = @xdoc.create_element('input')
      @current_node.append_child(element)
      element.append_attribute(@xdoc.create_attribute('id', id)) if id
      element.append_attribute(@xdoc.create_attribute('class', style)) if style
      element.append_attribute(@xdoc.create_attribute('name', 'commit'))
      element.append_attribute(@xdoc.create_attribute('type', 'submit'))
      element.append_attribute(@xdoc.create_attribute('value', label))

      nil
    end

    def image(image_name, id = nil, style = nil)
      element = @xdoc.create_element('img')
      @current_node.append_child(element)
      element.append_attribute(@xdoc.create_attribute('id', id)) if id
      element.append_attribute(@xdoc.create_attribute('class', style)) if style
      element.append_attribute(@xdoc.create_attribute('src', image_name))

      nil
    end

    def link_to(text, path, id = nil, style = nil)
      element = @xdoc.create_element('a')
      @current_node.append_child(element)
      element.append_attribute(@xdoc.create_attribute('id', id)) if id
      element.append_attribute(@xdoc.create_attribute('class', style)) if style
      element.append_attribute(@xdoc.create_attribute('href', path))
      element.inner_text = text

      nil
    end

    def email(text, url, id = nil, style = nil)
      element = @xdoc.create_element('a')
      @current_node.append_child(element)
      element.append_attribute(@xdoc.create_attribute('id', id)) if id
      element.append_attribute(@xdoc.create_attribute('class', style)) if style
      element.append_attribute(@xdoc.create_attribute('href', 'mailto:'+url))
      element.inner_text = text

      nil
    end

    def pop()
      @current_node = @current_node.parent_node

      nil
    end
  end
end

