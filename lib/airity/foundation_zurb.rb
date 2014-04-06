# Foundation Zurb DSL helpers.

def row(options = {}, &block)
  class_names = get_class_names(options[:styles])
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

