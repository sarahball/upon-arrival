class ApplicationDecorator < Draper::Decorator
  
  private
  def redactor_sanitize(body)
    h.sanitize(body, tags: %w(p br a ul ol li strong em))
  end

  def markdown_sanitize(body)
    h.sanitize(Kramdown::Document.new(body).to_html, tags: %w(p br a ul ol li strong em h2 h3 h4 h5 table tr td))
  end
end
