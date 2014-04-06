class Automation
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
    str << "<form action='/" + model_name + "' class='new_" + model_name + "' id='new_" + model_name + "' method='post'>"
    str << @crlf
    @indent = @indent + 2
    str
  end

  def label(field, text, style = '')
    str = indentation()
    if style.empty?
      str << '<label for="' + field + '">' + text + '</label>'
    else
      str << '<label for="' + field + '" class="' + style + '">' + text + '</label>'
    end
    str << @crlf
    str
  end

  def text_field(model_name, field)
    str = indentation()
    str << "<input id='" + model_name + "_" + field + "' name='" + model_name + "[" + field +"]' type='text'/>"
    str << @crlf
    str
  end

  def post_button(label)
    str = indentation()
    str << "<input name='commit' type='submit' value='"+label+"'/>"
    str << @crlf
    str
  end

  def image(image_name)
    str = indentation()
    str << '<img src="'+image_name+'"/>'
    str
  end

  def form_end()
    @indent = @indent - 2
    str = indentation()
    str << '</form>'
    str << @crlf
    str
  end

  def div_start(css_class='')
    str = indentation()

    str << '<div'

    unless css_class.empty?
      str << ' class="' + css_class + '"'
    end

    str << '>'
    str << @crlf
    @indent = @indent + 2
    str
  end

  def div_end()
    @indent = @indent - 2
    str = indentation()
    str << '</div>'
    str << @crlf
    str
  end

  def row_start(css = '')
    str = indentation()
    str << '<div class="row ' + css + '">'
    str << @crlf
    @indent = @indent + 2
    str
  end

  def row_end()
    @indent = @indent - 2
    str = indentation()
    str << '</div>'
    str << @crlf
    str
  end

  def columns_start(num_cols)
    str = indentation()
    str << '<div class="small-'+num_cols.to_s+' columns">'
    str << @crlf
    @indent = @indent + 2
    str
  end


  def columns_end()
    @indent = @indent - 2
    str = indentation()
    str << '</div>'
    str << @crlf
    str
  end

end

class HtmlDsl
  def initialize()
    @auto = Automation.new
    @str = ''
    @current_model_name = ''
  end

  def document(&block)
  end

  def html_head(&block)
  end

  def tags(&block)
    self.instance_eval(&block).to_s
  end

  def form(model_name, &block)
    @current_model = model_name
    @str << @auto.form_for(model_name)
    self.instance_eval(&block).to_s
    @str << @auto.form_end()
  end

  def div(css = '', &block)
    @str << @auto.div_start(css)
    self.instance_eval(&block).to_s
    @str << @auto.div_end()
  end

  # Foundation
  def row(css = '', &block)
    @str << @auto.row_start(css)
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

  def line_break()
    @str << '<br/>'
  end

  def label(field_name, text, style = '')
    @str << @auto.label(field_name, text, style)
  end

  def text_field(field_name)
    @str << @auto.text_field(@current_model_name, field_name)
  end

  def post_button(label)
    @str << @auto.post_button(label)
  end

  def image(image_name)
    @str << @auto.image(image_name)
  end
end

class Style
  attr_accessor :style_name
  attr_accessor :styles

  # provides for {@x = value; @y=value;} initialization syntax
  def initialize(&block)
    instance_eval(&block)
  end

  def get_css()
    str = '  .' << @style_name << '{'

    # key-value pair of the style.
    styles.each{|k, v|
      style_name = k.to_s.gsub('_', '-')
      str << style_name << ':' << v << ';'
    }

    str << '}'
    str
  end
end

class HomeController < ApplicationController
  def index
  end

  def new
    @user = User.new

    label_style = Style.new {
      @style_name = 'label-style'
      @styles =
          {
            font_size: '12px',
            margin_top: '4px'
          }
    }

    footer_label = Style.new {
      @style_name = 'footer-label'
      @styles =
          {
              font_size: '11px',
              text_align: 'center'
          }
    }

    right_justify = Style.new {
      @style_name = 'right-justify'
      @styles =
          {
              text_align: 'right',
          }
    }

    logo_text = Style.new {
      @style_name = 'logo-text'
      @styles =
          {
            text_align: 'right',
            font_family: 'Verdana,Arial,sans-serif',
            font_size: '12pt',
            color: '#4C3366'
          }
    }

    logo_padding = Style.new {
      @style_name = 'logo-padding'
      @styles =
          {
            padding_top: '15px',
          }
    }

    logo_padding2 = Style.new {
      @style_name = 'logo-padding2'
      @styles =
          {
              padding_bottom: '20px',
          }
    }

    row_page = Style.new {
      @style_name = 'row-page'
      @styles =
      {
        width: '100%',
        margin_left: '40px',      # use left margin and...
        margin_right: '0px',
        padding_left: '0px',
        padding_right: '80px'     # padding right (margin_left * 2)
      }
    }

    row_region = Style.new {
      @style_name = 'row-region'
      @styles =
          {
              width: '100%',
              margin_left: '40px',      # use left margin and...
              margin_right: '0px',
              padding_left: '0px',
              padding_right: '0px'     # padding right (margin_left * 2)
          }
    }

    div_border = Style.new {
      @style_name = 'div-border'
      @styles =
          {
              border: '1px solid',
              border_radius: '5px',
              padding_top: '10px',
              padding_right: '20px',
              padding_left: '20px',
          }
    }

    styles =
        [
            label_style.get_css(),
            row_page.get_css(),
            logo_text.get_css(),
            logo_padding.get_css(),
            logo_padding2.get_css(),
            footer_label.get_css(),
            right_justify.get_css(),
            div_border.get_css(),
            row_region.get_css(),
        ]

    # Accumulate all styles as an internal style sheet.
    # External / Internal / Inline: http://www.w3schools.com/css/css_howto.asp
    @page_style = "\r\n<style>\r\n" + styles.join("\r\n") + "</style>\r\n"

    header_dsl = HtmlDsl.new
    @header = header_dsl.tags do
      row('row-page') do
        columns_for(
            [
                [4, -> {image('HCOlogo.jpg')}],
                [12, -> {
                          label('dd1', '<b>Doula Data</b>', 'logo-text logo-padding')
                          label('dd2', 'A Data Collection System for Community-Based Doulas', 'logo-text logo-padding2')
                        }]
            ])
      end
    end

    footer_dsl = HtmlDsl.new
    @footer = footer_dsl.tags do
      row do line_break() end
      row do line_break() end
      row('row-page') do
        columns(16) do
          label('ftr1', '(c)2014 Health Connect One.  All Rights Reserved.', 'footer-label')
        end
      end
    end

    html_dsl = HtmlDsl.new
    html = html_dsl.form("user") do
      row('row-region') do
        columns(6) do
          div('div-border') do
            row do
              columns_for(
                         [
                           [6, -> {label('acct_name', 'Account Name:', 'label-style right-justify')}],
                           [10, -> {text_field('acct_name')}],
                         ])
            end
            row do
              columns_for(
                  [
                      [6, -> {label('password', 'Password:', 'label-style right-justify')}],
                      [10, -> {text_field('password')}],
                  ])
            end

            row do
              columns(1) do
                post_button("Sign In")
              end
            end

            row do line_break() end

            row do
              columns(16) do
                label('opt1', 'Forgot your account name or password?')
              end
            end

            row do
              columns(16) do
                label('opt2', 'About Doula Data')
              end
            end

            row do
              columns(16) do
                label('opt1', 'Don\'t have an account yet?')
              end
            end
          end
        end
      end
    end

    @script = html

    render :generic_view
  end

  def generic_view

  end
end
