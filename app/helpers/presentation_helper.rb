module PresentationHelper
  def read_presentations(dictionary)
    presentations = Presentations.new()

    doc = XML::Document.file('presentations.xml', :encoding => XML::Encoding::UTF_8, :options => LibXML::XML::Parser::Options::NOBLANKS)
    doc.root.children.each do |node|
      node_name = node.name
      case node_name
        when 'Presentation'
          presentation = Presentation.new()  {
            @name = node.attributes['Name']
            @view_name = node.attributes['View']
            @width = node.attributes['Width']
            @classes = node.attributes['Classes']
            @classes ||= ''
          }

          get_presentation_flow(node, presentation, dictionary)

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

  # html_dsl may be used by the string being evaluated.
  def evaluate(html_dsl, s)
    eval("\"#{s}\"")
  end

  def get_presentation_flow(node, presentation, dictionary)
    node.children.each do |flow_node|
      node_name = flow_node.name
      case node_name
        when 'Flow'
          flow = PresentationFlow.new() {
            @width = flow_node.attributes['Width']
            @classes = flow_node.attributes['Classes']
            @classes ||= ''
            @label_classes = flow_node.attributes['LabelClasses']
            @label_classes ||= ''
            @label_columns = flow_node.attributes['LabelColumns']
            @field_columns = flow_node.attributes['FieldColumns']
          }
          get_flow_fields(flow_node, flow, dictionary)
          presentation.add_flow(flow)
        else
          raise "Unsupported element name #{node_name}."
      end
    end

    nil
  end

  def get_flow_fields(node, flow, dictionary)
    node.children.each do |field|
      node_name = field.name
      case node_name
        when 'InputField'
          pfield = PresentationInputField.new() {
            name = field.attributes['Name']
            @definition = dictionary[name]
            @value = field.attributes['Value']
            raise "The field #{name} is missing a definition in the dictionary." unless @definition
          }
          flow.add_field(pfield)
        when 'LineBreak'
          pfield = PresentationLineBreak.new()
          flow.add_field(pfield)
        when 'LinkTo'
          pfield = PresentationLinkTo.new() {
            @label = field.attributes['Label']
            @url = field.attributes['url']
          }
          flow.add_field(pfield)
        else
          raise "Unsupported element name #{node_name}."
      end
    end
  end

  def presentation(presentation_name, html_dsl, fz_dsl, styles, &block)
    dictionary = read_dictionary()
    # schema = read_schema()
    presentations = read_presentations(dictionary)
    p = presentations[presentation_name]
    html_dsl.form(p.view_name, {id: 'register_user', action: 'register'}) do
      fz_dsl.row({classes: [styles.content_section]}) do
        fz_dsl.columns(p.width, {ext_classes: p.classes.split(' ')}) do
          p.flows.each do |flow|
            flow.fields.each do |field|
              fz_dsl.row do
                if field.definition
                  case field.definition.control
                    when 'CheckBox'
                      fz_dsl.columns(flow.width, {ext_classes: flow.classes.split(' ')}) do
                        html_dsl.checkbox(field.definition.name, nil, {classes: [styles.checkbox_valign]})
                        html_dsl.label(evaluate(html_dsl, field.definition.label))
                      end
                    when 'TextField'
                      fz_dsl.columns_for(
                          [
                              [flow.label_columns.to_i, -> {html_dsl.label(evaluate(html_dsl, field.definition.label), {id: field.definition.name, ext_classes: flow.label_classes.split(' ')})}],
                              [flow.field_columns.to_i, -> {
                                options = {id: field.definition.name, field_name: field.definition.name, data: ['required']}
                                options.merge!(value: field.value) if field.value
                                html_dsl.text_field(options)
                              }]
                          ])
                    when 'PasswordField'
                      fz_dsl.columns_for(
                          [
                              [flow.label_columns.to_i, -> {html_dsl.label(evaluate(html_dsl, field.definition.label), {id: field.definition.name, ext_classes: flow.label_classes.split(' ')})}],
                              [flow.field_columns.to_i, -> {
                                html_dsl.password_field({id: field.definition.name, field_name: field.definition.name, data: ['required']})
                              }]
                          ])
                  end
                else
                  case field.class.to_s
                    when 'PresentationLinkTo'
                      fz_dsl.columns(flow.width, {ext_classes: flow.classes.split(' ')}) do
                        html_dsl.link_to(field.label, field.url) # , {id: 'lnkPrivacyPolicy'})
                      end
                    when 'PresentationLineBreak'
                      fz_dsl.columns(flow.width, {ext_classes: flow.classes.split(' ')}) do
                        fz_dsl.row do html_dsl.line_break() end
                      end
                  end
                end
              end
            end
          end
        end

        yield unless block.nil?
      end
    end
  end
end
