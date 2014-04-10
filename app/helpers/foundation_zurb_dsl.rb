require 'airity_helpers'
include Airity

module Airity
  # Additional supporting functions for FZ elements.
  class FoundationZurbHtmlGenerator < HtmlGenerator
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

  class FoundationZurbDsl
    def initialize(html_dsl)
      @html_gen = FoundationZurbHtmlGenerator.new
      @html_dsl = html_dsl
    end
    
    def row(options = {})
      class_names = get_class_names(options)
      @html_dsl.output << @html_gen.row_start(class_names)
      yield
      @html_dsl.output << @html_gen.row_end()
    end

    def columns(num_cols)
      @html_dsl.output << @html_gen.columns_start(num_cols)
      yield
      @html_dsl.output << @html_gen.columns_end()
    end

# Array of columns, where each item is a 2 element array of the column width, lambda expression.
    def columns_for(col_dsl)
      rem_width = 16
      str = ''

      col_dsl.each_with_index{|col|
        columns(col[0]) do
          col[1].()
        end

        rem_width = rem_width - col[0]
      }

      if rem_width > 0
        columns(rem_width) do end
      end
    end

    def top_bar()
      @html_dsl.output << @html_gen.nav('top-bar', 'data-topbar')
      yield
      @html_dsl.output << @html_gen.nav_end()
    end

    def title_area()
      @html_dsl.output << @html_gen.ul('title-area')
      yield
      @html_dsl.output << @html_gen.ul_end()
    end

    def title_name(text, url, options)
      id = get_id(options)
      @html_dsl.output << @html_gen.li(id, '', 'name')
      @html_dsl.output << @html_gen.header(1)
      @html_dsl.output << @html_gen.link_to(text, url)
      @html_dsl.output << @html_gen.header_end(1)
      @html_dsl.output << @html_gen.li_end()
    end

    def top_bar_section()
      @html_dsl.output << @html_gen.section('top-bar-section')
      yield
      @html_dsl.output << @html_gen.section_end()
    end

    def left_menu()
      @html_dsl.output << @html_gen.ul('left')
      yield
      @html_dsl.output << @html_gen.ul_end()
    end

    def right_menu()
      @html_dsl.output << @html_gen.ul('right')
      yield
      @html_dsl.output << @html_gen.ul_end()
    end

    def menu_item(text, options ={})
      class_names = get_class_names(options)
      id = get_id(options)
      @html_dsl.output << @html_gen.li('', '', class_names)
      @html_dsl.output << @html_gen.link_to(text, '#', id)
      @html_dsl.output << @html_gen.li_end()
    end

    def menu_divider()
      @html_dsl.output << @html_gen.li('', '', 'divider')
      @html_dsl.output << @html_gen.li_end()
    end

    def dropdown_menu(text)
      @html_dsl.output << @html_gen.li('', '', 'has-dropdown')
      @html_dsl.output << @html_gen.link_to(text, '#')
      @html_dsl.output << @html_gen.ul('dropdown')
      yield
      @html_dsl.output << @html_gen.ul_end()
      @html_dsl.output << @html_gen.li_end()
    end

    def side_nav()
      @html_dsl.output << @html_gen.ul('side-nav')
      yield
      @html_dsl.output << @html_gen.ul_end()
    end
  end
end