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
  end
end

