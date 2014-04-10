# include Airity
include PageHelper
include StyleHelper

class HomeController < ApplicationController
  def index
  end

  def new
    @user = User.new

    # Accumulate all styles as an internal style sheet.
    # External / Internal / Inline: http://www.w3schools.com/css/css_howto.asp
    styles = AppStyles.new()
    @page_style = styles.css
    @header = get_header(styles) << get_top_bar(styles)
    @footer = get_footer(styles)

    html_dsl = HtmlDsl.new
    fz_dsl = FoundationZurbDsl.new(html_dsl)

    html_dsl.tags do
      fz_dsl.row({styles: [styles.content_section]}) do
        fz_dsl.columns_for(
            [
                [3, -> {
                  fz_dsl.side_nav do
                    html_dsl.list_item_link('Privacy Policy', '#')      # , {ext_styles: ['active']}
                    html_dsl.list_item_link('Terms and Conditions', '#')
                  end
                }],
                [12, -> {
                  html_dsl.div({id: 'home_text'}) do
                    html_dsl.p('Communities exist in many forms -- family, neighbors, your town, your friends, people interested in the same hobby, having the same religious affiliation, and so forth.')
                    html_dsl.p('People have amazing gifts to offer to others - their knowledge, services, skills, items, sometimes just a listening ear.')
                    html_dsl.p('And people also have needs -- help with groceries, repair work, gardening, a recommendation for a good book, sharing their interests...')
                    html_dsl.p('Needs and Gifts is about the opportunity to share our gifts and needs with others, whether they are our neighbors, friends, coworkers, people with like-minded interests, people that share our beliefs.')
                    html_dsl.p('As you are new to this site, visit the public community listings to see if anything sparks your interest. Or create your own community - simply register and click on the "Create A Community" link that is available to any registered member.')
                    html_dsl.p('If you are new to this site, consider:')
                    html_dsl.p('Thank you for visiting!')
                  end
                }]
            ]
        )
      end
    end

    @content = html_dsl.output
    render :generic_view
  end

  def generic_view

  end

  def test_foundation

  end
end


=begin
    html = html_dsl.form("user") do
      row({styles: [styles.content_section]}) do
        columns(6) do
          div({styles: [styles.div_border]}) do
            row do
              columns_for(
                         [
                           [6, -> {label('acct_name', 'Account Name:', {styles: [styles.label_style, styles.right_justify]})}],
                           [10, -> {text_field('acct_name')}],
                         ])
            end
            row do
              columns_for(
                  [
                      [6, -> {label('password', 'Password:', {styles: [styles.label_style, styles.right_justify]})}],
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
                label('opt1', 'Don\'t have an account yet?')
              end
            end
          end
        end
      end
    end
=end
