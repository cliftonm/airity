# Foundation Zurb DSL helpers.

def row(options = {}, &block)
  class_names = get_class_names(options)
  @str << @auto.row_start(class_names)
  self.instance_eval(&block).to_s
  @str << @auto.row_end()
end

def columns(num_cols, &block)
  @str << @auto.columns_start(num_cols)
  self.instance_eval(&block).to_s
  @str << @auto.columns_end()
end

# Array of columns, where each item is a 2 element array of the column width, lambda expression.
def columns_for(col_dsl)
  rem_width = 16

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

def top_bar(&block)
  @str << @auto.nav('top-bar', 'data-topbar')
  self.instance_eval(&block).to_s
  @str << @auto.nav_end()
end

def title_area(&block)
  @str << @auto.ul('title-area')
  self.instance_eval(&block).to_s
  @str << @auto.ul_end()
end

def title_name(text, url)
  @str << @auto.li('name')
  @str << @auto.header(1)
  @str << @auto.link_to(text, url)
  @str << @auto.header_end(1)
  @str << @auto.li_end()
end

def top_bar_section(&block)
  @str << @auto.section('top-bar-section')
  self.instance_eval(&block).to_s
  @str << @auto.section_end()
end

def left_menu(&block)
  @str << @auto.ul('left')
  self.instance_eval(&block).to_s
  @str << @auto.ul_end()
end

def right_menu(&block)
  @str << @auto.ul('right')
  self.instance_eval(&block).to_s
  @str << @auto.ul_end()
end

def menu_item(text, url, options ={})
  class_names = get_class_names(options)
  @str << @auto.li(class_names)
  @str << @auto.link_to(text, url)
  @str << @auto.li_end()
end

def menu_divider()
  @str << @auto.li('divider')
  @str << @auto.li_end()
end

def dropdown_menu(text, url, &block)
  @str << @auto.li('has-dropdown')
  @str << @auto.link_to(text, url)
  @str << @auto.ul('dropdown')
  self.instance_eval(&block).to_s
  @str << @auto.ul_end()
  @str << @auto.li_end()
end
