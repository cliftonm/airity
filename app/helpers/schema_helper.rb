module SchemaHelper
  # Schema read_schema()
  def read_schema()
    schema = Schema.new()
    doc = XML::Document.file('schema.xml', :encoding => XML::Encoding::UTF_8, :options => LibXML::XML::Parser::Options::NOBLANKS)
    doc.root.children.each do |node|
      node_name = node.name
      case node_name
        when 'Table'
          table = Table.new() {@name = node.attributes['Name']}
          get_table_fields(node, table)
          schema.add_table(table)
        when 'View'
          view = View.new() {@name = node.attributes['Name']}
          get_view_tables(node, view)
          schema.add_view(view)
        else
          raise "Unsupported element name #{node_name} off root."
      end
    end

    schema
  end

  # void get_table_fields(XML::Node node, Table table)
  def get_table_fields(node, table)
    node.children.each do |field_node|
      raise "Expected 'Field' tag in Table" unless field_node.name=='Field'
      field = Field.new() {
        @name = field_node.attributes['Name']
        @type = field_node.attributes['Type']
        @allow_null = field_node.attributes['AllowNull'] if field_node.attributes['AllowNull']
      }
      table.add_field(field)
    end

    nil
  end

  def get_view_tables(node, view)
    node.children.each do |view_node|
      node_name = view_node.name
      case node_name
        when 'Table'
          view_table = ViewTable.new() {@name = view_node.attributes['Name']}
          get_view_table_fields(view_node, view_table)
          view.add_view_table(view_table)
        when 'ViewField'
          view_field = ViewField.new() {
            @name = view_node.attributes['Name']
            @type = view_node.attributes['Type']
            @allow_null = view_node.attributes['AllowNull'] if view_node.attributes['AllowNull']
          }
          view.add_view_field(view_field)
        else
          raise "Unknown view element #{node_name}."
      end
    end

    nil
  end

  def get_view_table_fields(node, view_table)
    node.children.each do |view_table_field_node|
      view_table_field = ViewTableField.new() {@name = view_table_field_node.attributes['Name']}
      view_table.add_view_table_field(view_table_field)
    end

    nil
  end
end
