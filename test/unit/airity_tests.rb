require 'clifton_lib/xml/xml_text_writer'
include CliftonXml

# require 'style'
require '../../app/helpers/airity_helpers'
require '../../app/helpers/html_dsl'
require '../../app/helpers/html_generator'
# require 'foundation_zurb_dsl'
# require 'javascript_dsl'

require 'test/unit'
include Airity

class AirityTests < Test::Unit::TestCase
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

  private

  def get_output(dsl)
    tw = XmlTextWriter.new()
    tw.formatting = :indented
    dsl.html_gen.xdoc.save(tw)

    tw.output
  end
end