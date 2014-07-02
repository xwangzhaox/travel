module ApplicationHelper

  def none_html_content(content)
    return "" if content.nil?
    content.gsub(/<.*?>/, "")[0..200]+"..."
  end
end
