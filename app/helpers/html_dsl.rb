module Airity
  class HtmlDsl
    attr_accessor :output
    attr_reader :html_gen

    def initialize()
      @html_gen = HtmlGenerator.new
      @current_model_name = ''
    end

    def document(&block)
    end

    def html_head(&block)
    end

    def body
      @html_gen.body()
      yield
      @html_gen.body_end()
    end

    def form(model_name)
      @current_model_name = model_name
      @html_gen.form_for(model_name)
      yield
      @html_gen.form_end()
    end

    def div(options = {})
      class_names = get_class_names(options)
      id = get_id(options)
      @html_gen.div(id, class_names)
      yield
      @html_gen.div_end()
    end

    def line_break()
      @html_gen.line_break()
    end

    def label(text, options ={})
      class_names = get_class_names(options)
      id = get_id(options)
      field_name = get_field_name(options)
      @html_gen.label(text, field_name, id, class_names)
    end

    def text_field(options = {})
      class_names = get_class_names(options)
      id = get_id(options)
      field_name = get_field_name(options)
      @html_gen.text_field(@current_model_name, field_name, id, class_names)
    end

    def post_button(label, options = {})
      class_names = get_class_names(options)
      id = get_id(options)
      @html_gen.post_button(label, id, class_names)
    end

    def image(image_name, options = {})
      class_names = get_class_names(options)
      id = get_id(options)
      @html_gen.image(image_name, id, class_names)
    end

    def link_to(text, path, options = {})
      class_names = get_class_names(options)
      id = get_id(options)
      @html_gen.link_to(text, path, id, class_names)
    end

    def email(text, url, options = {})
      class_names = get_class_names(options)
      id = get_id(options)
      @html_gen.email(text, url, id, class_names)
    end

    def p(text, options = {})
      class_names = get_class_names(options)
      id = get_id(options)
      @html_gen.p(text, id, class_names)
    end

    def list(options = {})
      class_names = get_class_names(options)
      @html_gen.ul(class_names)
      yield
      @html_gen.ul_end
    end

    def list_item_link(text, url, options = {})
      class_names = get_class_names(options)
      @html_gen.li('', '', class_names)
      @html_gen.link_to(text, url)
      @html_gen.li_end()
    end
  end
end