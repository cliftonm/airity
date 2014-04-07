module Airity
  class HtmlDsl
    require 'airity/foundation_zurb'

    def initialize()
      @auto = HtmlGenerator.new
      @str = ''
      @current_model_name = ''
    end

    # ==========================================================

    # helper to get class names from an array of classes.
    def get_class_names(options)
      class_names = []

      styles = options[:styles]

      # Internal styles using Style class.
      if styles
        styles.each{|style| class_names << style.style_name}
      end

      ext_styles = options[:ext_styles]

      # External styles as strings.
      if ext_styles
        ext_styles.each{|style| class_names << style}
      end

      class_names.join(' ')
    end

    # ==========================================================

    def document(&block)
    end

    def html_head(&block)
    end

    def tags(&block)
      self.instance_eval(&block).to_s
    end

    def form(model_name, &block)
      @current_model_name = model_name
      @str << @auto.form_for(model_name)
      self.instance_eval(&block).to_s
      @str << @auto.form_end()
    end

    def div(options = {}, &block)
      class_names = get_class_names(options)
      @str << @auto.div_start(class_names)
      self.instance_eval(&block).to_s
      @str << @auto.div_end()
    end

    def line_break()
      @str << '<br/>'
    end

    def label(field_name, text, options ={})
      class_names = get_class_names(options)
      @str << @auto.label(field_name, text, class_names)
    end

    def text_field(field_name, options = {})
      class_names = get_class_names(options)
      @str << @auto.text_field(@current_model_name, field_name, class_names)
    end

    def post_button(label, options = {})
      class_names = get_class_names(options)
      @str << @auto.post_button(label, class_names)
    end

    def image(image_name, options = {})
      class_names = get_class_names(options)
      @str << @auto.image(image_name, class_names)
    end

    def link_to(text, path, options = {})
      class_names = get_class_names(options)
      @str << @auto.link_to(text, path, class_names)
    end

    def email(text, url, options = {})
      class_names = get_class_names(options)
      @str << @auto.email(text, url, class_names)
    end

    def p(text, options = {})
      class_names = get_class_names(options)
      @str << @auto.p(text, class_names)
    end
  end
end