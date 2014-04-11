require 'style'
include Airity

module StyleHelper
  class AppStyles
    attr_accessor :header_section
    attr_accessor :menu_section
    attr_accessor :content_section
    attr_accessor :footer_section
    attr_accessor :label_style
    attr_accessor :right_justify
    attr_accessor :h1_ng
    attr_accessor :h2_ng
    attr_accessor :div_border
    attr_accessor :color_white
    attr_accessor :css

    def initialize()
      @header_section = Style.new {
        @style_name = 'header-section'
        @styles =
            {
                width: '100%',
                margin_left: '40px',      # use left margin and...
                margin_right: '0px',
                padding_top: '40px',
                padding_bottom: '20px',
                padding_left: '0px',
                padding_right: '80px'     # padding right (margin_left * 2)
            }
      }

      @content_section = Style.new {
        @style_name = 'content-section'
        @styles =
            {
                width: '100%',
                margin_left: '40px',      # use left margin and...
                margin_right: '0px',
                padding_top: '40px',
                padding_bottom: '20px',
                padding_left: '0px',
                padding_right: '80px'     # padding right (margin_left * 2)
            }
      }

      @menu_section = Style.new {
        @style_name = 'menu-section'
        @styles =
            {
                width: '100%',
                margin_left: '40px',      # use left margin and...
                margin_right: '0px',
                padding_top: '0px',
                padding_bottom: '0px',
                padding_left: '0px',
                padding_right: '80px'     # padding right (margin_left * 2)
            }
      }

      @footer_section = Style.new {
        @style_name = 'footer-section'
        @styles =
            {
                font_size: '11px',
                text_align: 'center'
            }
      }

      @label_style = Style.new {
        @style_name = 'label-style'
        @styles =
            {
                font_size: '12px',
                margin_top: '4px'
            }
      }

      @right_justify = Style.new {
        @style_name = 'right-justify'
        @styles =
            {
                text_align: 'right',
            }
      }

      @h1_ng = Style.new {
        @style_name = 'h1-ng'
        @styles =
            {
                font_family: 'Verdana,Arial,sans-serif',
                font_size: '12pt',
                font_weight: 'bold',
                color: '#4C3366'
            }
      }

      @h2_ng = Style.new {
        @style_name = 'h2-ng'
        @styles =
            {
                font_family: 'Verdana,Arial,sans-serif',
                font_size: '12pt',
                color: '#4C3366'
            }
      }

      @div_border = Style.new {
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

      @color_white = Style.new {
        @style_name = 'color-white'
        @styles =
            {
                color: '#ffffff;',
            }
      }

      styles =
          [
              @label_style.get_css(),
              @header_section.get_css(),
              @menu_section.get_css(),
              @content_section.get_css(),
              @footer_section.get_css(),
              @h1_ng.get_css(),
              @h2_ng.get_css(),
              @right_justify.get_css(),
              @div_border.get_css(),
              @color_white.get_css(),
          ]

      @css = "\r\n<style type='text/css'>\r\n" + styles.join("\r\n") + "</style>\r\n"
    end
  end
end