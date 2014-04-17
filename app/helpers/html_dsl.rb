require 'airity_helpers'

module Airity
  class HtmlDsl
    attr_accessor :output
    attr_reader :html_gen

    def initialize()
      @html_gen = HtmlGenerator.new
      @current_model_name = ''

      self
    end

    def document(&block)

      nil
    end

    def html_head(&block)

      nil
    end

    # Convenience for getting into a block that starts appending children to the current XmlDocument node (usually root, so we can create sub-xml)
    def tags
      yield
    end

    def body(options = {})
      class_names = get_class_names(options)
      id = get_id(options)
      @html_gen.body(id, class_names)
      yield
      @html_gen.body_end()

      nil
    end

    def form(model_name)
      @current_model_name = model_name
      @html_gen.form_for(model_name)
      yield
      @html_gen.form_end()

      nil
    end

    def div(options = {})
      class_names = get_class_names(options)
      styles = get_styles(options)
      id = get_id(options)
      @html_gen.div(id, class_names, styles)
      yield
      @html_gen.div_end()

      nil
    end

    # void nav(Hash options = nil)
    def nav(options = {})
      class_names = get_class_names(options)
      id = get_id(options)
      data = get_data(options)
      @html_gen.nav(id, class_names, data)
      yield
      @html_gen.nav_end()

      nil
    end

    def ul(options = {})
      class_names = get_class_names(options)
      id = get_id(options)
      @html_gen.ul(id, class_names)
      yield
      @html_gen.ul_end()

      nil
    end

    def li(text, options = {})
      class_names = get_class_names(options)
      id = get_id(options)
      @html_gen.li(text, id, class_names)
      yield
      @html_gen.li_end()

      nil
    end

    def section(options = {})
      class_names = get_class_names(options)
      id = get_id(options)
      @html_gen.section(id, class_names)
      yield
      @html_gen.section_end()

      nil
    end

    def header(header_num, text = nil, options = {})
      class_names = get_class_names(options)
      id = get_id(options)
      @html_gen.header(header_num, text, id, class_names)

      if text.nil?
        yield
      end

      @html_gen.header_end()

      nil
    end

    def line_break()
      @html_gen.line_break()

      nil
    end

    def label(text, options ={})
      class_names = get_class_names(options)
      id = get_id(options)
      field_name = get_field_name(options)
      @html_gen.label(text, field_name, id, class_names)

      nil
    end

    def text_field(options = {})
      class_names = get_class_names(options)
      id = get_id(options)
      field_name = get_field_name(options)
      @html_gen.text_field(@current_model_name, field_name, id, class_names)

      nil
    end

    def post_button(label, options = {})
      class_names = get_class_names(options)
      id = get_id(options)
      @html_gen.post_button(label, id, class_names)

      nil
    end

    def checkbox(field_name, text = nil, options = {})
      class_names = get_class_names(options)
      id = get_id(options)
      @html_gen.checkbox(@current_model_name, field_name, text, id, class_names)

      nil
    end

    def image(image_name, options = {})
      class_names = get_class_names(options)
      id = get_id(options)
      @html_gen.image(image_name, id, class_names)

      nil
    end

    def link_to(text, path, options = {})
      class_names = get_class_names(options)
      id = get_id(options)
      @html_gen.link_to(text, path, id, class_names)

      nil
    end

    def email(text, url, options = {})
      class_names = get_class_names(options)
      id = get_id(options)
      @html_gen.email(text, url, id, class_names)

      nil
    end

    def p(text, options = {})
      class_names = get_class_names(options)
      id = get_id(options)
      @html_gen.p(text, id, class_names)

      nil
    end

    def p_block(options = {})
      class_names = get_class_names(options)
      id = get_id(options)
      @html_gen.p_block(id, class_names)
      yield
      @html_gen.pop()

      nil
    end

    def list(options = {})
      class_names = get_class_names(options)
      @html_gen.ul(class_names)
      yield
      @html_gen.ul_end

      nil
    end

    def list_item_link(text, url, options = {})
      class_names = get_class_names(options)
      id = get_id(options)
      @html_gen.li(nil, id, class_names)
      @html_gen.link_to(text, url, id)
      @html_gen.li_end()

      nil
    end

    # string inline(lambda expr(HtmlDsl dsl))
    def inline(expr)
      inline_dsl = HtmlDsl.new()              # create a local instance for just this expression
      expr.(inline_dsl)                       # execute the expression
      tw = XmlTextWriter.new()                # create a text writer
      tw.allow_self_closing_tags = false      # HTML5 compliance
      inline_dsl.html_gen.xdoc.save(tw)       # generate the HTML

      tw.output                               # return the result
    end

    # void inject(string html)
    def inject(html)
      @html_gen.inject(html)

      nil
    end
  end
end

