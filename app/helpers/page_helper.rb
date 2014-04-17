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
      fz_dsl.row({classes: [styles.header_section]}) do
        fz_dsl.columns_for(
            [
                [4, -> {html_dsl.image('/images/community.jpg')}],
                [12, -> {
                  html_dsl.div({classes: [styles.right_justify]}) do
                    html_dsl.label('Needs and Gifts', {id: 'dd1', classes: [styles.h1_ng]})
                    html_dsl.label('People Living in Community', {id: 'dd2', classes: [styles.h2_ng]})
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
      fz_dsl.row( {classes: [styles.menu_section]}) do
        html_dsl.div({ext_classes: ['contain-to-grid sticky']}) do
          fz_dsl.top_bar() do
            fz_dsl.title_area() do
              fz_dsl.title_name('Needs &amp; Gifts', '#', {id: 'mnuHome'})
              fz_dsl.top_bar_section do
                fz_dsl.left_menu do
                  fz_dsl.menu_item('How It Works', {id: 'mnuHowItWorks'}) # , ext_classes: ['active']})
                  fz_dsl.menu_divider
                  fz_dsl.menu_item('Public Communities', {id: 'mnuPublicCommunities'})
                end
                fz_dsl.right_menu do
                  fz_dsl.menu_item('Register', {id: 'mnuRegister'}) #, ext_classes: ['active']})
                  fz_dsl.menu_divider
                  fz_dsl.menu_item('Sign In', {id: 'mnuSignIn'})
=begin
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
=end
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
      fz_dsl.row( {classes: [styles.footer_section]}) do
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
    menu_items = ['mnuHowItWorks', 'mnuRegister', 'mnuPublicCommunities', 'mnuPrivacyPolicy', 'mnuTandA', 'mnuSignIn']
    text_content = ['home_text', 'how_it_works_text', 'sign_in_page', 'register_page', 'tanda_text', 'privacy_policy_text']

    on_click_make_active(js_dsl, menu_items)
    clear_all_active_menu_items(js_dsl, menu_items)
    hide_all_text_content(js_dsl, text_content)

    # The home menu clears all active menu / sidebar selections.
    js_dsl.on_click('#mnuHome') {
      js_dsl.call_function('clearAllActiveMenuItems')
      js_dsl.call_function('hideAllTextContent')
      js_dsl.show('#home_text')
    }

    # The menus themselves handle the "active" visualization.
    js_dsl.on_click('#mnuHowItWorks') {
      js_dsl.call_function('hideAllTextContent')
      js_dsl.show('#how_it_works_text')
    }

    js_dsl.on_click('#mnuSignIn') {
      js_dsl.call_function('hideAllTextContent')
      js_dsl.show('#sign_in_page')
    }

    js_dsl.on_click('#mnuRegister') {
      js_dsl.call_function('hideAllTextContent')
      js_dsl.show('#register_page')
    }

    js_dsl.on_click('#mnuPrivacyPolicy') {
      js_dsl.call_function('hideAllTextContent')
      js_dsl.show('#privacy_policy_text')
    }

    js_dsl.on_click('#mnuTandA') {
      js_dsl.call_function('hideAllTextContent')
      js_dsl.show('#tanda_text')
    }

    # Show the Privacy Policy, activating the sidebar link.
    js_dsl.on_click('#lnkPrivacyPolicy') {
      js_dsl.call_function('hideAllTextContent')
      js_dsl.call_function('clearAllActiveMenuItems')
      js_dsl.add_class("li#mnuPrivacyPolicy", 'active')
      js_dsl.show('#privacy_policy_text')
    }

    # Show the Terms and Conditions, activating the sidebar link.
    js_dsl.on_click('#lnkTandA') {
      js_dsl.call_function('hideAllTextContent')
      js_dsl.call_function('clearAllActiveMenuItems')
      js_dsl.add_class("li#mnuTandA", 'active')
      js_dsl.show('#tanda_text')
    }

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

  def on_click_make_active(js_dsl, menu_list)
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

  def clear_all_active_menu_items(js_dsl, menu_list)
    js_dsl.function('clearAllActiveMenuItems') do
      menu_list.each do |menu_item|
        js_dsl.remove_class("li##{menu_item}", 'active')
      end
    end
  end

  def hide_all_text_content(js_dsl, id_list)
    js_dsl.function('hideAllTextContent') do
      id_list.each do |id|
        js_dsl.hide("##{id}")
      end
    end
  end

  private

  def get_output(dsl)
    tw = XmlTextWriter.new()
    tw.formatting = :indented
    tw.allow_self_closing_tags = false
    dsl.html_gen.xdoc.save(tw)

    tw.output
  end

end
