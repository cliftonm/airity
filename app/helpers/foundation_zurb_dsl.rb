module Airity
  class FoundationZurbDsl
    attr_reader :html_dsl

    def initialize(html_dsl)
      @html_gen = html_dsl.html_gen
      @html_dsl = html_dsl

      self
    end
    
    def row(options = {})
      class_names = get_class_names(options)
      id = get_id(options)

      if class_names.nil?
        class_names = 'row'
      else
        class_names = 'row ' << class_names
      end

      @html_gen.div(id, class_names)
      yield
      @html_gen.div_end()

      nil
    end

    def columns(num_cols, options = {})
      class_names = get_class_names(options)
      id = get_id(options)
      styles = 'small-'+num_cols.to_s << ' columns'
      styles << ' ' + class_names if class_names
      @html_gen.div(id, styles)
      yield
      @html_gen.div_end()

      nil
    end

# Array of columns, where each item is a 2 element array of the column width, lambda expression.
    def columns_for(col_dsl)
      rem_width = 16
      str = ''

      col_dsl.each{|col|
        columns(col[0]) do
          col[1].()
        end

        rem_width = rem_width - col[0]
      }

      if rem_width > 0
        columns(rem_width) do end
      end

      nil
    end

    def top_bar()
      @html_gen.nav(nil, 'top-bar', ['data-topbar'])
      yield
      @html_gen.nav_end()

      nil
    end

    def title_area(options = {})
      id = get_id(options)
      @html_gen.ul(id, 'title-area')
      yield
      @html_gen.ul_end()

      nil
    end

    def title_name(text, url, options)
      id = get_id(options)
      @html_gen.li(nil, id, 'name')
      @html_gen.header(1)
      @html_gen.link_to(text, url)
      @html_gen.header_end()
      @html_gen.li_end()

      nil
    end

    def top_bar_section()
      @html_gen.section(nil, 'top-bar-section')
      yield
      @html_gen.section_end()

      nil
    end

    def left_menu()
      @html_gen.ul(nil, 'left')
      yield
      @html_gen.ul_end()

      nil
    end

    def right_menu()
      @html_gen.ul(nil, 'right')
      yield
      @html_gen.ul_end()

      nil
    end

    def menu_item(text, options ={})
      class_names = get_class_names(options)
      id = get_id(options)
      @html_gen.li(nil, id, class_names)
      @html_gen.link_to(text, '#', id)
      @html_gen.li_end()

      nil
    end

    def menu_divider()
      @html_gen.li(nil, nil, 'divider')
      @html_gen.li_end()

      nil
    end

    def dropdown_menu(text)
      @html_gen.li(nil, nil, 'has-dropdown')
      @html_gen.link_to(text, '#')
      @html_gen.ul(nil, 'dropdown')
      yield
      @html_gen.ul_end()
      @html_gen.li_end()

      nil
    end

    def side_nav()
      @html_gen.ul(nil, 'side-nav')
      yield
      @html_gen.ul_end
    end
  end
end