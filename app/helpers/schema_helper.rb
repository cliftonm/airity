module SchemaHelper
  def read_dictionary()
    dictionary = Dictionary.new()
    doc = XML::Document.file('dictionary.xml', :encoding => XML::Encoding::UTF_8, :options => LibXML::XML::Parser::Options::NOBLANKS)
    doc.root.children.each do |node|
      node_name = node.name
      case node_name
        when 'Definition'
          definition = Definition.new() {
            @name = node.attributes['Name']
            @type = node.attributes['Type']
            @control = node.attributes['Control']
            @label = node.attributes['Label']
          }
          dictionary.add_definition(definition)
        else
          raise "Expected element name 'Definition'."
      end
    end

    dictionary
  end

  # Schema read_schema()
  def read_schema()
    dictionary = read_dictionary()
    schema = Schema.new()
    doc = XML::Document.file('schema.xml', :encoding => XML::Encoding::UTF_8, :options => LibXML::XML::Parser::Options::NOBLANKS)
    doc.root.children.each do |node|
      node_name = node.name
      case node_name
        when 'Table'
          table = Table.new() {@name = node.attributes['Name']}
          get_table_fields(node, table, dictionary)
          schema.add_table(table)
        when 'View'
          view = View.new() {@name = node.attributes['Name']}
          get_view_tables(node, view, dictionary, schema)
          schema.add_view(view)
        else
          raise "Unsupported element name #{node_name} off root."
      end
    end

    schema
  end

  # void get_table_fields(XML::Node node, Table table)
  def get_table_fields(node, table, dictionary)
    node.children.each do |field_node|
      raise "Expected 'Field' tag in Table" unless field_node.name=='Field'
      field = Field.new() {
        definition_name = field_node.attributes['Name']
        @definition = dictionary[definition_name]
        raise "#{definition_name} is not defined in the dictionary.  Please add it." unless definition
        @allow_null = field_node.attributes['AllowNull'] if field_node.attributes['AllowNull']
      }
      table.add_field(field)
    end

    nil
  end

  def get_view_tables(node, view, dictionary, schema)
    node.children.each do |view_node|
      node_name = view_node.name
      case node_name
        when 'Table'
          view_table_name = view_node.attributes['Name']
          table = schema.tables.find {|t| t.name == view_table_name}
          raise "View #{view.name} is referencing an undefined table #{view_table_name}." unless table
          view_table = ViewTable.new() {@table = table}
          get_view_table_fields(view_node, view_table, schema)
          view.add_view_table(view_table)
        when 'ViewField'
          view_field = ViewField.new() {
            definition_name = view_node.attributes['Name']
            @definition = dictionary[definition_name]
            raise "#{definition_name} is not defined in the dictionary.  Please add it." unless definition
            @allow_null = view_node.attributes['AllowNull'] if view_node.attributes['AllowNull']
          }
          view.add_view_field(view_field)
        else
          raise "Unknown view element #{node_name}."
      end
    end

    nil
  end

  def get_view_table_fields(node, view_table, schema)
    table = view_table.table
    node.children.each do |view_table_field_node|
      view_table_field_name = view_table_field_node.attributes['Name']
      field = table[view_table_field_name]
      raise "View table #{view_table.name} is referencing an unknown table field #{view_table_field_name}." unless field
      view_table_field = ViewTableField.new() {@table_field = field}
      view_table.add_view_table_field(view_table_field)
    end

    nil
  end
end
