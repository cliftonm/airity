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
    @javascript = get_javascript()

    html_dsl = HtmlDsl.new
    fz_dsl = FoundationZurbDsl.new(html_dsl)

    html_dsl.tags do
      fz_dsl.row({classes: [styles.content_section]}) do
        fz_dsl.columns_for(
            [
                [3, -> {
                  fz_dsl.side_nav do
                    html_dsl.list_item_link('Privacy Policy', '#', {id: 'mnuPrivacyPolicy'})      # , {ext_classes: ['active']}
                    html_dsl.list_item_link('Terms and Conditions', '#', {id: 'mnuTandA'})
                  end
                }],
                [12, -> {
                  home_text_markup(html_dsl)
                  how_it_works_markup(html_dsl)
                  sign_in_markup(html_dsl, fz_dsl, styles)
                }]
            ]
        )
      end
    end

    @content = get_output(html_dsl)
    render :generic_view
  end

  def generic_view

  end

  def test_foundation

  end

  def test_jquery

  end

  private

  # TODO: Dupicate code!
  def get_output(dsl)
    tw = XmlTextWriter.new()
    tw.formatting = :indented
    dsl.html_gen.xdoc.save(tw)

    tw.output
  end

  def home_text_markup(html_dsl)
    html_dsl.div({id: 'home_text'}) do
      html_dsl.p('Communities exist in many forms -- family, neighbors, your town, your friends, people interested in the same hobby, having the same religious affiliation, and so forth.')
      html_dsl.p('People have amazing gifts to offer to others - their knowledge, services, skills, items, sometimes just a listening ear.')
      html_dsl.p('And people also have needs -- help with groceries, repair work, gardening, a recommendation for a good book, sharing their interests...')
      html_dsl.p('Needs and Gifts is about the opportunity to share our gifts and needs with others, whether they are our neighbors, friends, coworkers, people with like-minded interests, people that share our beliefs.')
      html_dsl.p('As you are new to this site, visit the public community listings to see if anything sparks your interest. Or create your own community - simply register and click on the "Create A Community" link that is available to any registered member.')
      html_dsl.p('If you are new to this site, consider:')
      html_dsl.p('Thank you for visiting!')
    end
  end

  def how_it_works_markup(html_dsl)
    html_dsl.div({id: 'how_it_works_text', styles: ['display: none']}) do
      html_dsl.header(3, 'Getting Started')
      html_dsl.p('Creating a community takes only two steps. First, Register onto the site. Once registered, you can click on the Create A Community link that will appear on the sidebar.')
      html_dsl.header(3, 'Creating a Community')
      html_dsl.p('Once you have registered, you can create your own public or private community. All that is needed a name for your community and a brief description. Begin with clicking on the Create A Community link on the sidebar.')
      html_dsl.header(3, 'Joining a Public Community')
      html_dsl.p('Public communities can be joined by registered users. Click on the Join A Community link on the sidebar. A list of public communities will be shown, which you can join.')
      html_dsl.header(3, 'Joining a Private Community')
      html_dsl.p('A private community can only be joined by invitation. Once you\'ve registered, the private communities to which you have been invited can be viewed by clicking on the My Invitations link on the sidebar. From there, you can accept or decline the invitation.')
      html_dsl.header(3, 'Visiting a Community')
      html_dsl.p('You can belong to multiple communities. When you sign in, the communities that you belong to are displayed on the home page. You can visit a community by clicking on the "Visit" link. You can also see your communities by clicking on the My Communities link on the sidebar.')
      html_dsl.header(3, 'Viewing Needs or Gifts')
      html_dsl.p('When you visit a community, the menu bar will include a Needs and Gifts selection. After you choose one, you can view the needs or gifts currently posted there. You can also add your own need or gift.')
      html_dsl.header(3, 'Responding to a Need or Gift')
      html_dsl.p('For each need or gift, you can respond if you can help with that need or are interested in that gift. Provide a short message as part of your response. This message can then be viewed by the original poster. Please note that no emails are sent to you, if someone is responding to your need or gift, or to the original poster, if you are responding to someone else\'s need or gift.')
      html_dsl.header(3, 'Viewing Responses to my Needs and Gifts')
      html_dsl.p('Once you have posted a need or gift and someone responds, you can view those responses by clicking on the My Inbox link on the sidebar. This will show you all your unread (new) responses as well as all your old (read) responses. If you choose, you may reply to the post, negotiate price, provide contact information, etc.')
      html_dsl.header(3, 'Sending Invitations to a Private Community')
      html_dsl.p('If you are the community administrator, you can send invitations to other members of your community from the Admin menu. It\'s important to send the invitation from within the Needs and Gifts website rather than as a separate email, because Needs And Gifts will track the invitations and add them to the member\'s My Invitations list.')
      html_dsl.p('The categories that you can choose from are determined by the community administrator. If you are a community administrator, you can change the default categories at any time by visiting the Admin page.')
      html_dsl.header(3, 'Forums')
      html_dsl.p('The forums are available for any registered user, but they are specific to the community that you are visiting. Only the community administrator can add new forums, but members are free to add topics and posts.')
      html_dsl.header(3, 'Leaving a Community')
      html_dsl.p('You are free to leave a community whenever you wish. You will no longer be able to visit that community. If you leave a private community, you will need to be re-invited in order to rejoin that community.')
    end
  end

  def sign_in_markup(html_dsl, fz_dsl, styles)
    html_dsl.div({id: 'sign_in_page', styles: ['display: none']}) do
      html_dsl.form("user") do
        fz_dsl.row({classes: [styles.content_section]}) do
          fz_dsl.columns(8, {ext_classes: ['small-offset-3']}) do
            html_dsl.div({classes: [styles.div_border]}) do
              fz_dsl.row do
                fz_dsl.columns_for(
                  [
                   [5, -> {html_dsl.label('Account Name:', {id: 'acct_name', classes: [styles.label_style, styles.right_justify]})}],
                   [11, -> {html_dsl.text_field({id: 'acct_name'})}],
                  ])
              end
              fz_dsl.row do
                fz_dsl.columns_for(
                  [
                    [5, -> {html_dsl.label('Password:', {id: 'password', classes: [styles.label_style, styles.right_justify]})}],
                    [11, -> {html_dsl.text_field({id: 'password'})}],
                  ])
              end

              fz_dsl.row do
                fz_dsl.columns(1, {ext_classes: ['small-offset-7']}) do
                  html_dsl.post_button("Sign In")
                end
              end

              fz_dsl.row do html_dsl.line_break() end

              fz_dsl.row do
                fz_dsl.columns(16) do
                  html_dsl.label('Forgot your account name or password?')
                end
              end

              fz_dsl.row do
                fz_dsl.columns(16) do
                  html_dsl.label('Don\'t have an account yet?')
                end
              end
            end
          end
        end
      end
    end
  end
end
