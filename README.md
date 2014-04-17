Airity
==
A Comprehensive Domain Specific Language (DSL) for Web Application Development

**_"Do it all in Ruby"_**

Airity is a DSL for generating HTML, CSS, and Javascript directly in Ruby.  The impetus for creating this project is:

 - work only in the native language instead of multiple syntaxes, formats, and languages
 - create a library of re-usable visual components and behaviors based on a unified "package" of Ruby code.  All the HTML, CSS, and Javascript of a component can be re-used in seconds, which is not possible when a a "component" is smeared across CSS, HTML, and Ruby code.
 - Support UI components like Foundation, Bootstrap, etc. by extending the DSL, again with the intention of creating re-usable components.
 - One "language" to rule them all!

Of course, one still needs to know CSS, HTML, Javascript, and so forth.  But the goal is "do it once and forget it" for many of the repetitive aspects of web application development.

Furthermore:

> Do it all in Ruby

is the mantra.  We'll see how close to that goal we can get.

This Project is in its Infancy
--
The current form of this repository is intended to explore re-creating a website (http://needsandgifts.herokuapp.com/) that we developed in straight Ruby, HTML, and CSS.  This is a good exercise for the core implementation of the DSL, but it means that at the moment, the DSL code and the website specific code is a bit entangled.  Eventually the DSL code will become a gem.

A Word About DSL's
--
You are, unfortunately, at our mercy for what we think the DSL function names and parameters should be.  Furthermore, what you're seeing in the above examples is very close to the bone -- there's no deep syntax-sugaring going on here.

Roadmap
==
While the DSL is current an internal DSL and is intended to remain that way, we intend to support XML (ie. an external DSL) for representing schemas, UI layout, and binding.  XML will be the serialization format of tools to help visually create the declarative data.  We don't want to serialize to Ruby code because this isn't cross-language/platform compatible.  However, at all times, Ruby, as the internal DSL language, will be supported for all functionality.

Furthermore, the goal is to let the schema specify much of the behavior of the UI (field labels, control types, validation, dependencies, etc.) and to remove the complexity of creating rich database schema from the Ruby code -- schema belongs in a schema, not in code.  Schema, along with layout information, drives the presentation, its behavior, and the back-end database transactions.

That said, there needs to be a clear separation between the DSL that is responsible for the presentation and other aspects of the automation process (the schema, for example.)  Concepts such as workflow, validation, schema/model persistence -- these are all intended to be separate modules, rather than entangled in the DSL presentation code base.

This Isn't Rocket Science
--
There are several HTML DSL's out there.  However, to our knowledge, this is the first attempt to integrate presentation, model definition, and model persistence into a loosely coupled framework.  It also seems to be the first attempt to unify HTML, CSS, and Javascript "code generation" under the umbrella of a single language (Ruby in our first implementation.)

About Our Coding Style
==
 - We prefer a more object-oriented style of coding than native-speaking Ruby'ists may be comfortable with.
 - we prefer things like explicit return values.
 - Idiomatic Ruby is fine, but we like to wrap the idioms in English readable functions.
 - We like small, well documented functions.

If you're comfortable with those guidelines, then you're welcome to contribute to the code base.  In a nutshell, your code is expected:
 - to be commented
 - to adhere to object oriented principles (mixins are NOT condoned)

Website Development
--
A significant issue with web application development is with the placement of "business logic", especially the code that controls presentation.  We've seen too many times the same code written in ERB, repeated in Ruby directly, repeated in Javascript, and smeared across multiple files.  This is terrible implementation and results in costly maintenance.

Coding everything in Ruby with DSL's doesn't address this problem -- it's still possible to write spaghetti code, and writing conditional logic nested inside "do" blocks is not only ugly, it's bad practice.  Community, you can do better.

So, write a function to determine what state the presentation should be in, and don't write it again.  As this code base matures, the ability to write server-side Ruby and translate it into client-side Javascript will grow and mature.  We recognize that client-side Javascript is necessary for performance and that it must often be mirrored on the server-side.  But it should not be necessary to write the same code twice, even if it is for two different languages.

Examples
==
NOTE: AS OF 4/17/2014, THESE EXAMPLE ARE OUTDATED.  I will update the examples soon.

Note that we use Slim and SASS for my markup, so you'll see this syntax in view pages.

All of these example are likely to change at this point!

A Basic View Page
--
This is the code for a generic view page:

```ruby
= @page_style.html_safe
= @header.html_safe
= @content.html_safe
= @footer.html_safe
```

It has 4 parts:
 * the style specific for the page
 * the header
 * the page content
 * the footer

Obviously your page can have any content you choose.

Creating Styles
--
Styles are created by instantiating instances of the Style class.  The hash keys should map exactly to the desired CSS style, except use the '_' character.  For example:

```ruby
require 'style'
include Airity

module StyleHelper
  class AppStyles
    attr_reader :header_section
    attr_reader :css

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

   styles =
          [
              @header_section.get_css(),
              # more styles...
          ]

      @css = "\r\n<style>\r\n" + styles.join("\r\n") + "</style>\r\n"
    end
  end
end
```
It's a bit ugly right now, but the idea is to define each of your styles and assign them to a read-only attribute.  The composite set of styles is assigned, for example, the the attribute ```css```.  The intention with "attributed" styles is that your IDE can auto-complete your style references.

A Basic Usage Example
--
This example illustrates combining standard HTML/CSS markup with Foundation Zurb's features.

```ruby
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

```
Here we instantiate the "root" DSL engine ```HtmlDsl``` and as well as the FoundationZurb DSL engine ```FoundationZurbDsl```.  Note that we pass the root engine to the other component engines.

We then generate the HTML, specifying styles and so forth, for the header.

A Foundation Menu Example
--
Here's how the DSL is used to create a menu:
```ruby
  def get_top_bar(styles)
    html_dsl = HtmlDsl.new
    fz_dsl = FoundationZurbDsl.new(html_dsl)

    html_dsl.tags do
      fz_dsl.row( {styles: [styles.menu_section]}) do
        html_dsl.div({ext_styles: ['contain-to-grid sticky']}) do
          fz_dsl.top_bar() do
            fz_dsl.title_area() do
              fz_dsl.title_name('Needs &amp; Gifts', '#')
              fz_dsl.top_bar_section do
                fz_dsl.left_menu do
                  fz_dsl.menu_item('How It Works', '#')
                  fz_dsl.menu_divider
                  fz_dsl.menu_item('Register', '#')  #, {ext_styles: ['active']})
                  fz_dsl.menu_divider
                  fz_dsl.menu_item('Public Communities', '#')
                end
                fz_dsl.right_menu do
                  fz_dsl.menu_item('Menu 3', '#')
                  fz_dsl.menu_item('Menu 4', '#')
                  fz_dsl.dropdown_menu('Menu 5', '#') do
                    fz_dsl.menu_item('Sub 1', '#')
                    fz_dsl.menu_item('Sub 2', '#')
                    fz_dsl.dropdown_menu('Sub 3', '#') do
                      fz_dsl.menu_item('Sub 3-1', '#')
                      fz_dsl.menu_item('Sub 3-2', '#')
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
```

Installation
==
The current repository includes a sample website.  Create the database and run the website.

```sh
git clone git@github.com:cliftonm/airity.git
cd airity
[configure database.yml]
[create the database in Postgres]
rake db:migrate
rails -s
```


License
==

MIT

