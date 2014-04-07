include Airity

module PageHelper
  def get_header(styles)
    # TODO: Why do we have to specify Airity:: for the first time something in this module is encountered?
    header = "\r\n" << Airity::HtmlDsl.new.tags do
      row({styles: [styles.header_section]}) do
        columns_for(
            [
                [4, -> {image('/images/community.jpg')}],
                [12, -> {
                  div({styles: [styles.right_justify]}) do
                    label('dd1', 'Needs and Gifts', {styles: [styles.h1_ng]})
                    label('dd2', 'People Living in Community', {styles: [styles.h2_ng]})
                    link_to('Sign In', '/sign_in')
                  end
                }]
            ])
      end
    end

    header
  end

  def get_top_bar(styles)
    my_top_bar = "\r\n" << Airity::HtmlDsl.new.tags do
      row({styles: [styles.menu_section]}) do
        div({ext_styles: ['contain-to-grid sticky']}) do
          top_bar do
            title_area do
              title_name('Needs &amp; Gifts', '#')
              top_bar_section do
                left_menu do
                  menu_item('How It Works', '#')
                  menu_divider()
                  menu_item('Register', '#') #, {ext_styles: ['active']})
                  menu_divider()
                  menu_item('Public Communities', '#')
                end
                right_menu do
                  menu_item('Menu 3', '#')
                  menu_item('Menu 4', '#')
                  dropdown_menu('Menu 5', '#') do
                    menu_item('Sub 1', '#')
                    menu_item('Sub 2', '#')
                    dropdown_menu('Sub 3', '#') do
                      menu_item('Sub 3-1', '#')
                      menu_item('Sub 3-2', '#')
                    end
                  end
                end
              end
            end
          end
        end
      end
    end

    my_top_bar
  end

  def get_footer(styles)
    footer = HtmlDsl.new.tags do
      line_break()
      line_break()
      row({styles: [styles.footer_section]}) do
        columns(16) do
          label('ftr1', '&copy; ' + DateTime.now.year.to_s + ' Marc Clifton.  All Rights Reserved.')
          email('Contact Us', 'marc.clifton@gmail.com')
          line_break()
          link_to('Donate', '/donate')
        end
      end
    end

    footer
  end
end
