module Airity
  # helper to get class names from an array of classes.
#  class AirityHelpers

  # return nil or a space separated list of class names specified by the :styles and :ext_styles options.
  # :styles must be is an array of Style instances.
  # :ext_styles must be an array of strings.
  def get_class_names(options)
    ret = nil
    class_names = []

    styles = options[:styles]

    # Internal styles using Style class.
    if styles
      styles.each{|style|
        class_names << style.style_name
      }
    end

    ext_styles = options[:ext_styles]

    # External styles as strings.
    if ext_styles
      ext_styles.each{|style|
        class_names << style
      }
    end

    if class_names.count > 0
      ret = class_names.join(' ')
    end

    ret
  end

  # Return nil or the value of the :id key in options
  def get_id(options)
    id = options[:id]

    id
  end

  # Returns nil or the value of the :field_name key in options
  def get_field_name(options)
    field_name = options[:field_name]

    field_name
  end

  def get_option(options, sym)
    ret = options[sym]
    ret ||= ''

    ret
  end

#   end
end
