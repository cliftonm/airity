module Airity
  # helper to get class names from an array of classes.
#  class AirityHelpers
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
#   end
end