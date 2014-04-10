module Airity
  # Helper class for an element's attribute-value pair.
  class AttributeValue
    attr_reader :attr
    attr_reader :val

    def initialize(attr, val)
      @attr = attr
      @val = val
    end
  end

  # An XML element
  class Element
    def initialize(tag_name)
      @tag_name = tag_name
      @attribute_values = []
      @data_attributes = []
      @close_element = false
      @inner_xml = ''

      self
    end

    # For manually closing a tag later on.
    def self.close(tag_name)
      '</' + tag_name + '>'
    end

    # An attribute of an XML element.  Requires val1, val2 is optional and is appended to val1.
    # Example:
    # attribute('for', field)
    # attribute('action', '/', model_name)
    def attribute(attr, val1, val2=nil)
      val = val1
      val << val2 unless val2.nil?
        @attribute_values << AttributeValue.new(attr, val)

      self
    end

    # If the value isn't blank, then add the attribute
    def conditional_attribute(attr, val)
      unless val.blank?
        @attribute_values << AttributeValue.new(attr, val)
      end

      self
    end

    def conditional_inner_xml(str)
      unless str.blank?
        @inner_xml = str
      end

      self
    end

    def data_attribute(attr)
      @data_attributes << attr

      self
    end

    def inner_xml(str)
      @inner_xml = str

      self
    end

    def close()
      @close_element = true

      self
    end

    def conditional_close()
      unless @inner_xml.blank?
        @close_element = true
      end

      self
    end

    # Converts the XML element to a string.
    def to_string()
      str = '<' << @tag_name << ' '

      @attribute_values.each do |kvp|
        str << kvp.attr << '="' << kvp.val << '" '
      end

      @data_attributes.each do |data|
        str << data << ' '
      end

      if @close_element
        if @inner_xml.blank?
          str << '/>'
        else
          str << '>' << @inner_xml << '</' << @tag_name << '>'
        end
      else
        str << '>' << @inner_xml
      end

      str
    end
  end
end
