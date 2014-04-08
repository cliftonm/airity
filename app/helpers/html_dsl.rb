module Airity
  class HtmlDsl
    attr_accessor :output

    def initialize()
      @html_gen = HtmlGenerator.new
      @current_model_name = ''
      @output = ''
    end

    def document(&block)
    end

    def html_head(&block)
    end

    def tags
      yield
    end

    def form(model_name)
      @current_model_name = model_name
      @output << @html_gen.form_for(model_name)
      yield
      @output << @html_gen.form_end()
    end

    def div(options = {})
      class_names = get_class_names(options)
      @output << @html_gen.div_start(class_names)
      yield
      @output << @html_gen.div_end()
    end

    def line_break()
      @output << '<br/>'
    end

    def label(field_name, text, options ={})
      class_names = get_class_names(options)
      @output << @html_gen.label(field_name, text, class_names)
    end

    def text_field(field_name, options = {})
      class_names = get_class_names(options)
      @output << @html_gen.text_field(@current_model_name, field_name, class_names)
    end

    def post_button(label, options = {})
      class_names = get_class_names(options)
      @output << @html_gen.post_button(label, class_names)
    end

    def image(image_name, options = {})
      class_names = get_class_names(options)
      @output << @html_gen.image(image_name, class_names)
    end

    def link_to(text, path, options = {})
      class_names = get_class_names(options)
      @output << @html_gen.link_to(text, path, class_names)
    end

    def email(text, url, options = {})
      class_names = get_class_names(options)
      @output << @html_gen.email(text, url, class_names)
    end

    def p(text, options = {})
      class_names = get_class_names(options)
      @output << @html_gen.p(text, class_names)
    end

    def list(options = {})
      class_names = get_class_names(options)
      @output << @html_gen.ul(class_names)
      yield
      @output << @html_gen.ul_end
    end

    def list_item_link(text, url, options = {})
      class_names = get_class_names(options)
      @output << @html_gen.li(class_names)
      @output << @html_gen.link_to(text, url)
      @output << @html_gen.li_end()
    end
  end
end