module PresentationHelper
  def read_presentations()
    presentations = Presentations.new()

    doc = XML::Document.file('presentations.xml', :encoding => XML::Encoding::UTF_8, :options => LibXML::XML::Parser::Options::NOBLANKS)
    doc.root.children.each do |node|
      node_name = node.name
      case node_name
        when 'Presentation'
          presentation = Presentation.new()  {
            @name = node.attributes['Name']
            @view_name = node.attributes['View']
            @columns = node.attributes['Columns']
            @classes = node.attributes['Classes']
            @label_classes = node.attributes['LabelClasses']
            @label_columns = node.attributes['LabelColumns']
            @field_columns = node.attributes['FieldColumns']
          }

          get_presentation_metadata(node, presentation)

          presentations.add_presentation(presentation)
        else
          raise "Unsupported element name #{node_name} off root."
      end
    end

    presentations
  end

  def to_boolean(s)
    !!(s =~ /^(true|t|yes|y|1)$/i)
  end

  def get_presentation_metadata(node, presentation)
    node.children.each do |metadata_node|
      node_name = metadata_node.name
      case node_name
        when 'Metadata'
          metadata = PresentationMetadata.new() {
            @field = metadata_node.attributes['Field']
            @control = metadata_node.attributes['Control']
            @label = metadata_node.attributes['Label']
            @columns = metadata_node.attributes['Columns']
            @classes = metadata_node.attributes['Classes']
            @classes ||= ''
            @value = metadata_node.attributes['Value']
            @url = metadata_node.attributes['URL']
            @inline = PresentationHelper::to_boolean(metadata_node.attributes['Inline'])
          }
          presentation.add_metadata(metadata)
        else
          raise "Unsupported element name #{node_name}."
      end
    end

    nil
  end

  def presentation(presentation_name, html_dsl, fz_dsl, styles, &block)
    schema = read_schema()
    presentations = read_presentations()
    p = presentations[presentation_name]
    html_dsl.form(p.view_name, {id: 'register_user', action: 'register'}) do
      fz_dsl.row({classes: [styles.content_section]}) do
        fz_dsl.columns(p.columns, {ext_classes: p.classes.split(' ')}) do
          p.metadata.each do |metadata|
            fz_dsl.row do
              if metadata.inline
                fz_dsl.columns(metadata.columns, {ext_classes: metadata.classes.split(' ')}) do
                  case metadata.control
                    when 'Checkbox'
                      html_dsl.checkbox(metadata.field, nil, {classes: [styles.checkbox_valign]})
                      html_dsl.label(eval("\"#{metadata.label}\""))
                    when 'LinkTo'
                      html_dsl.link_to(metadata.label, metadata.url) # , {id: 'lnkPrivacyPolicy'})
                    when 'LineBreak'
                      fz_dsl.row do html_dsl.line_break() end
                  end
                end
              else
                fz_dsl.columns_for(
                    [
                        [p.label_columns.to_i, -> {html_dsl.label(metadata.label, {id: metadata.field, ext_classes: p.label_classes.split(' ')})}],
                        [p.field_columns.to_i, -> {
                          case metadata.control
                            when 'TextField'
                              options = {id: metadata.field, field_name: metadata.field, data: ['required']}
                              options.merge!(value: metadata.value) if metadata.value
                              html_dsl.text_field(options)
                            when 'PasswordField'
                              html_dsl.password_field({id: metadata.field, field_name: metadata.field, data: ['required']})
                          end
                        }],
                    ])
              end
            end
          end

          yield unless block.nil?
        end
      end
    end
  end
end
