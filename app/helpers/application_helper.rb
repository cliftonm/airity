module ApplicationHelper
  # Assign @page_title in controller to override default title.
  def render_title
    return @page_title if defined?(@page_title)
    "Automation Test"
  end
end
