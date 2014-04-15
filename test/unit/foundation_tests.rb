require 'clifton_lib/xml/xml_text_writer'
include CliftonXml

# require 'style'
require '../../app/helpers/airity_helpers'
require '../../app/helpers/html_dsl'
require '../../app/helpers/html_generator'
require '../../app/helpers/foundation_zurb_dsl'
# require 'foundation_zurb_dsl'
# require 'javascript_dsl'

require 'test/unit'
include Airity

class FoundationTests < Test::Unit::TestCase
  def test_row()
    dsl = HtmlDsl.new()
    fz = FoundationZurbDsl.new(dsl)
    dsl.body() {
      fz.row({id: 'id1', ext_styles: ['style1']}) {}
    }
    output = get_output(dsl)

    assert_equal %Q|<body>\r\n  <div id="id1" class="style1"/>\r\n</body>|, output
  end

  def test_columns()
    dsl = HtmlDsl.new()
    fz = FoundationZurbDsl.new(dsl)
    dsl.body() {
      fz.columns(2, {id: 'id1', ext_styles: ['style1']}) {}
    }
    output = get_output(dsl)

    assert_equal %Q|<body>\r\n  <div id="id1" class="small-2 columns style1"/>\r\n</body>|, output
  end

  def test_top_bar()
    dsl = HtmlDsl.new()
    fz = FoundationZurbDsl.new(dsl)
    dsl.body() {
      fz.top_bar() {}
    }
    output = get_output(dsl)

    assert_equal %Q|<body>\r\n  <nav top-bar data-topbar/>\r\n</body>|, output
  end

  def test_top_bar_section()
    dsl = HtmlDsl.new()
    fz = FoundationZurbDsl.new(dsl)
    dsl.body() {
      fz.top_bar_section() {}
    }
    output = get_output(dsl)

    assert_equal %Q|<body>\r\n  <section class="top-bar-section"/>\r\n</body>|, output
  end

  def test_title_area()
    dsl = HtmlDsl.new()
    fz = FoundationZurbDsl.new(dsl)
    dsl.body() {
      fz.title_area() {}
    }
    output = get_output(dsl)

    assert_equal %Q|<body>\r\n  <ul class="title-area"/>\r\n</body>|, output
  end

  def test_title_name()
    dsl = HtmlDsl.new()
    fz = FoundationZurbDsl.new(dsl)
    dsl.body() {
      fz.title_name('name', 'url', {id: 'id1'})
    }
    output = get_output(dsl)

    assert_equal %Q|<body>\r\n  <li id="id1" class="name">\r\n    <h1>\r\n      <a href="url">name</a>\r\n    </h1>\r\n  </li>\r\n</body>|, output
  end

  def test_left_menu()
    dsl = HtmlDsl.new()
    fz = FoundationZurbDsl.new(dsl)
    dsl.body() {
      fz.left_menu() {}
    }
    output = get_output(dsl)

    assert_equal %Q|<body>\r\n  <ul class="left"/>\r\n</body>|, output
  end

  def test_right_menu()
    dsl = HtmlDsl.new()
    fz = FoundationZurbDsl.new(dsl)
    dsl.body() {
      fz.right_menu() {}
    }
    output = get_output(dsl)

    assert_equal %Q|<body>\r\n  <ul class="right"/>\r\n</body>|, output
  end

  def test_side_nav()
    dsl = HtmlDsl.new()
    fz = FoundationZurbDsl.new(dsl)
    dsl.body() {
      fz.side_nav() {}
    }
    output = get_output(dsl)

    assert_equal %Q|<body>\r\n  <ul class="side-nav"/>\r\n</body>|, output
  end

  def test_menu_item()
    dsl = HtmlDsl.new()
    fz = FoundationZurbDsl.new(dsl)
    dsl.body() {
      fz.menu_item('Foobar')
    }
    output = get_output(dsl)

    assert_equal %Q|<body>\r\n  <li>\r\n    <a href="#">Foobar</a>\r\n  </li>\r\n</body>|, output
  end

  def test_menu_divider()
    dsl = HtmlDsl.new()
    fz = FoundationZurbDsl.new(dsl)
    dsl.body() {
      fz.menu_divider()
    }
    output = get_output(dsl)

    assert_equal %Q|<body>\r\n  <li class="divider"/>\r\n</body>|, output
  end

  def test_dropdown_menu()
    dsl = HtmlDsl.new()
    fz = FoundationZurbDsl.new(dsl)
    dsl.body() {
      fz.dropdown_menu('Foobar') {}
    }
    output = get_output(dsl)

    assert_equal %Q|<body>\r\n  <li class="has-dropdown">\r\n    <a href="#">Foobar</a>\r\n    <ul class="dropdown"/>\r\n  </li>\r\n</body>|, output
  end

  private

  def get_output(dsl)
    tw = XmlTextWriter.new()
    tw.formatting = :indented
    dsl.html_gen.xdoc.save(tw)

    tw.output
  end
end