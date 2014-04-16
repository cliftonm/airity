require 'clifton_lib/xml/xml_text_writer'
include CliftonXml

# We need to update the load path so that we find the helper files in the right folders.
$:.unshift File.expand_path('../../../app/helpers', __FILE__)

# require 'style'
require 'airity_helpers'
require 'html_dsl'
require 'html_generator'
# require 'foundation_zurb_dsl'
# require 'javascript_dsl'

require 'test/unit'
include Airity

class HtmlDslTests < Test::Unit::TestCase
  def test_create_body()
    dsl = HtmlDsl.new()
    dsl.body() {}
    output = get_output(dsl)

    assert_equal %Q|<body/>|, output
  end

  def test_create_form()
    dsl = HtmlDsl.new()
    dsl.body() {
      dsl.form('user') {}
    }
    output = get_output(dsl)

    assert_equal %Q|<body>\r\n  <form id="new_user" action="/user" class="new_user" method=\"post\"/>\r\n</body>|, output
  end

  def test_div()
    dsl = HtmlDsl.new()
    dsl.body() {
      dsl.div({id: 'id1', ext_styles: ['class1']}) {}
    }
    output = get_output(dsl)

    assert_equal %Q|<body>\r\n  <div id="id1" class="class1"/>\r\n</body>|, output
  end

  def test_nav()
    dsl = HtmlDsl.new()
    dsl.body() {
      dsl.nav({id: 'id1', ext_styles: ['class1'], data: ['data_topbar']}) {}
    }
    output = get_output(dsl)

    assert_equal %Q|<body>\r\n  <nav id="id1" class="class1" data-topbar/>\r\n</body>|, output
  end

  def test_ul()
    dsl = HtmlDsl.new()
    dsl.body() {
      dsl.ul({id: 'id1', ext_styles: ['class1']}) {}
    }
    output = get_output(dsl)

    assert_equal %Q|<body>\r\n  <ul id="id1" class="class1"/>\r\n</body>|, output
  end

  def test_li()
    dsl = HtmlDsl.new()
    dsl.body() {
      dsl.li('Apples', {id: 'id1', ext_styles: ['class1']}) {}
    }
    output = get_output(dsl)

    assert_equal %Q|<body>\r\n  <li id="id1" class="class1">Apples</li>\r\n</body>|, output
  end

  def test_section()
    dsl = HtmlDsl.new()
    dsl.body() {
      dsl.section({id: 'id1', ext_styles: ['class1']}) {}
    }
    output = get_output(dsl)

    assert_equal %Q|<body>\r\n  <section id="id1" class="class1"/>\r\n</body>|, output
  end

  def test_header()
    dsl = HtmlDsl.new()
    dsl.body() {
      dsl.header(1, {id: 'id1', ext_styles: ['class1']}) {}
    }
    output = get_output(dsl)

    assert_equal %Q|<body>\r\n  <h1 id="id1" class="class1"/>\r\n</body>|, output
  end

  def test_line_break()
    dsl = HtmlDsl.new()
    dsl.body() {
      dsl.line_break()
    }
    output = get_output(dsl)

    assert_equal %Q|<body>\r\n  <br/>\r\n</body>|, output
  end

  def test_label
    dsl = HtmlDsl.new()
    dsl.body() {
      dsl.label('label1', {id: 'id1', ext_styles: ['class1']}) {}
      dsl.label('label2', {field_name: 'field1', ext_styles: ['class1']}) {}
    }
    output = get_output(dsl)

    assert_equal %Q|<body>\r\n  <label id="id1" class="class1">label1</label>\r\n  <label id="lbl_field1" class="class1">label2</label>\r\n</body>|, output
  end

  def test_text_field
    dsl = HtmlDsl.new()
    dsl.body() {
      dsl.form('user') {
        dsl.text_field({field_name: 'field1', ext_styles: ['class1']}) {}
      }
    }
    output = get_output(dsl)

    assert_equal %Q|<body>\r\n  <form id="new_user" action="/user" class="new_user" method="post">\r\n    <input id="user_field1" name="user[field1]" class="class1" type="text"/>\r\n  </form>\r\n</body>|, output
  end

  def test_paragraph
    dsl = HtmlDsl.new()
    dsl.body() {
      dsl.p('A paragraph', {id: 'id1', ext_styles: ['class1']})
    }
    output = get_output(dsl)

    assert_equal %Q|<body>\r\n  <p id="id1" class="class1">A paragraph</p>\r\n</body>|, output
  end

  def test_post_button
    dsl = HtmlDsl.new()
    dsl.body() {
      dsl.post_button('Save', {id: 'id1', ext_styles: ['class1']})
    }
    output = get_output(dsl)

    assert_equal %Q|<body>\r\n  <input id="id1" class="class1" name="commit" type="submit" value="Save"/>\r\n</body>|, output
  end

  def test_post_image
    dsl = HtmlDsl.new()
    dsl.body() {
      dsl.image('save.jpg', {id: 'id1', ext_styles: ['class1']})
    }
    output = get_output(dsl)

    assert_equal %Q|<body>\r\n  <img id="id1" class="class1" src="save.jpg"/>\r\n</body>|, output
  end

  def test_link_to
    dsl = HtmlDsl.new()
    dsl.body() {
      dsl.link_to('Me', 'selfie.com', {id: 'id1', ext_styles: ['class1']})
    }
    output = get_output(dsl)

    assert_equal %Q|<body>\r\n  <a id="id1" class="class1" href="selfie.com">Me</a>\r\n</body>|, output
  end

  def test_mail_to
    dsl = HtmlDsl.new()
    dsl.body() {
      dsl.email('Send Money', 'me@gmail.com', {id: 'id1', ext_styles: ['class1']})
    }
    output = get_output(dsl)

    assert_equal %Q|<body>\r\n  <a id="id1" class="class1" href="mailto:me@gmail.com">Send Money</a>\r\n</body>|, output
  end

  private

  def get_output(dsl)
    tw = XmlTextWriter.new()
    tw.formatting = :indented
    dsl.html_gen.xdoc.save(tw)

    tw.output
  end
end