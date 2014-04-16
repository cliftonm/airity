module Airity
  class JavascriptDsl
    attr_reader :output

    def initialize()
      @output = "<script type='text/javascript'>"
    end

    def done()
      @output << "</script>\r\n"
    end

    def on_click(tag)
      @output << %Q|$("#{tag}").click(function() {|
      yield
      @output << "});\r\n"

      ''
    end

    def add_class(tag, class_name)
      @output << %Q|$("#{tag}").addClass("#{class_name}");|

      ''
    end

    def remove_class(tag, class_name)
      @output << %Q|$("#{tag}").removeClass("#{class_name}");|

      ''
    end

    def toggle(tag)
      @output << %Q|$("#{tag}").toggle();|

      ''
    end

    def show(tag)
      @output << %Q|$("#{tag}").show();|

      ''
    end

    def hide(tag)
      @output << %Q|$("#{tag}").hide();|

      ''
    end
  end
end

