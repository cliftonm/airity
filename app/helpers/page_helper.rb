# include Airity
# Example:
# include DateTimeRendering
# require File.expand_path('utility_functions','lib')
# include UtilityFunctions

require 'clifton_lib/xml/xml_text_writer'

require 'style'
require 'html_dsl'
require 'html_generator'
require 'foundation_zurb_dsl'
require 'javascript_dsl'
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
                    html_dsl.label('Needs and Gifts', {id: 'dd1', styles: [styles.h1_ng]})
                    html_dsl.label('People Living in Community', {id: 'dd2', styles: [styles.h2_ng]})
                    html_dsl.link_to('Sign In', '/sign_in')
                  end
                }]
            ])
      end
    end

    "\r\n" << get_output(html_dsl)
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
                  fz_dsl.menu_item('How It Works', {id: 'mnuHowItWorks'}) # , ext_styles: ['active']})
                  fz_dsl.menu_divider
                  fz_dsl.menu_item('Register', {id: 'mnuRegister'}) #, ext_styles: ['active']})
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

    "\r\n" << get_output(html_dsl)
  end

  def get_footer(styles)
    html_dsl = HtmlDsl.new
    fz_dsl = FoundationZurbDsl.new(html_dsl)

    html_dsl.tags do
      html_dsl.line_break()
      html_dsl.line_break()
      fz_dsl.row( {styles: [styles.footer_section]}) do
        fz_dsl.columns(16) do
          html_dsl.label('&copy; ' + DateTime.now.year.to_s + ' Marc Clifton.  All Rights Reserved.', {id: 'ftr1'})
          html_dsl.email('Contact Us', 'marc.clifton@gmail.com')
          html_dsl.line_break()
          html_dsl.link_to('Donate', '/donate')
        end
      end
    end

    "\r\n" << get_output(html_dsl)
  end

  def get_javascript
    js_dsl = JavascriptDsl.new()

    on_click_select(js_dsl, ['mnuHowItWorks', 'mnuRegister', 'mnuPublicCommunities'])
# Doing it very manually:
=begin
    js_dsl.on_click('a#mnuHowItWorks') do
      js_dsl.add_class('li#mnuHowItWorks', 'active')
      js_dsl.remove_class('li#mnuRegister', 'active')
      js_dsl.remove_class('li#mnuPublicCommunities', 'active')
    end

    js_dsl.on_click('a#mnuRegister') do
      js_dsl.remove_class('li#mnuHowItWorks', 'active')
      js_dsl.add_class('li#mnuRegister', 'active')
      js_dsl.remove_class('li#mnuPublicCommunities', 'active')
    end

    js_dsl.on_click('a#mnuPublicCommunities') do
      js_dsl.remove_class('li#mnuHowItWorks', 'active')
      js_dsl.remove_class('li#mnuRegister', 'active')
      js_dsl.add_class('li#mnuPublicCommunities', 'active')
    end
=end
    js_dsl.done()

    js_dsl.output
  end

  def on_click_select(js_dsl, menu_list)
    menu_list.each_with_index do |menu_click, index_click|
      js_dsl.on_click("a##{menu_click}") do
        menu_list.each_with_index do |menu_select, index_select|
          if index_click == index_select
            js_dsl.add_class("li##{menu_select}", 'active')
          else
            js_dsl.remove_class("li##{menu_select}", 'active')
          end
        end
      end
    end
  end

  private

  def get_output(dsl)
    tw = XmlTextWriter.new()
    tw.formatting = :indented
    dsl.html_gen.xdoc.save(tw)

    tw.output
  end

end
