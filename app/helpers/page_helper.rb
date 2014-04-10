# include Airity
# Example:
# include DateTimeRendering
# require File.expand_path('utility_functions','lib')
# include UtilityFunctions

require 'style'
require 'html_dsl'
require 'html_generator'
require 'foundation_zurb_dsl'
include Airity

module PageHelper
  def get_header(styles)
    html_dsl = HtmlDsl.new
    fz_dsl = FoundationZurbDsl.new(html_dsl)

    html_dsl.tags do
      fz_dsl.row({styles: [styles.header_section]}) do
        fz_dsl.columns_for(
            [
                [4, -> {html_dsl.image('/images/community.jpg')}],
                [12, -> {
                  html_dsl.div({styles: [styles.right_justify]}) do
                    html_dsl.label('dd1', 'Needs and Gifts', {styles: [styles.h1_ng]})
                    html_dsl.label('dd2', 'People Living in Community', {styles: [styles.h2_ng]})
                    html_dsl.link_to('Sign In', '/sign_in')
                  end
                }]
            ])
      end
    end

    "\r\n" << html_dsl.output
  end

  def get_top_bar(styles)
    html_dsl = HtmlDsl.new
    fz_dsl = FoundationZurbDsl.new(html_dsl)

    html_dsl.tags do
      fz_dsl.row( {styles: [styles.menu_section]}) do
        html_dsl.div({ext_styles: ['contain-to-grid sticky']}) do
          fz_dsl.top_bar() do
            fz_dsl.title_area() do
              fz_dsl.title_name('Needs &amp; Gifts', '#', {id: 'mnuHome'})
              fz_dsl.top_bar_section do
                fz_dsl.left_menu do
                  fz_dsl.menu_item('How It Works', {id: 'mnuHowItWorks'})
                  fz_dsl.menu_divider
                  fz_dsl.menu_item('Register', {id: 'mnuRegister'})  #, {ext_styles: ['active']})
                  fz_dsl.menu_divider
                  fz_dsl.menu_item('Public Communities', {id: 'mnuPublicCommunities'})
                end
                fz_dsl.right_menu do
                  fz_dsl.menu_item('Menu 3')
                  fz_dsl.menu_item('Menu 4')
                  fz_dsl.dropdown_menu('Menu 5') do
                    fz_dsl.menu_item('Sub 1')
                    fz_dsl.menu_item('Sub 2')
                    fz_dsl.dropdown_menu('Sub 3') do
                      fz_dsl.menu_item('Sub 3-1')
                      fz_dsl.menu_item('Sub 3-2')
                    end
                  end
                end
              end
            end
          end
        end
      end
    end

    "\r\n" << html_dsl.output
  end

  def get_footer(styles)
    html_dsl = HtmlDsl.new
    fz_dsl = FoundationZurbDsl.new(html_dsl)

    html_dsl.tags do
      html_dsl.line_break()
      html_dsl.line_break()
      fz_dsl.row( {styles: [styles.footer_section]}) do
        fz_dsl.columns(16) do
          html_dsl.label('ftr1', '&copy; ' + DateTime.now.year.to_s + ' Marc Clifton.  All Rights Reserved.')
          html_dsl.email('Contact Us', 'marc.clifton@gmail.com')
          html_dsl.line_break()
          html_dsl.link_to('Donate', '/donate')
        end
      end
    end

    "\r\n" << html_dsl.output
  end
end
