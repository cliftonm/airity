module Airity
  # helper to get class names from an array of classes.
#  class AirityHelpers

  # return nil or a space separated list of class names specified by the :classes and :ext_classes options.
  # :classes must be is an array of Style instances.
  # :ext_classes must be an array of strings.
  # string get_class_names(Hash options)
  def get_class_names(options)
    ret = nil
    class_names = []

    classes = options[:classes]

    # Internal styles using Style class.
    if classes
      classes.each{|clss|
        class_names << clss.style_name
      }
    end

    ext_classes = options[:ext_classes]

    # External styles as strings.
    if ext_classes
      ext_classes.each{|clss|
        class_names << clss
      }
    end

    if class_names.count > 0
      ret = class_names.join(' ')
    end

    ret
  end

  def get_styles(options)
    ret = nil
    style_names = []

    styles = options[:styles]

    if styles
      styles.each{|style|
        style_names << style
      }
    end

    if style_names.count > 0
      ret = style_names.join(' ')
    end

    ret
  end

  # string id = get_id(Hash options)
  def get_id(options)
    id = options[:id]

    id
  end

  # string[] data = get_data(Hash options)
  def get_data(options)
    data = options[:data]
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
