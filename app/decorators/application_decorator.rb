class ApplicationDecorator < Draper::Decorator
  
  private
  def redactor_sanitize(body)
    h.sanitize(body, tags: %w(p br a ul ol li strong em))
  end

  def markdown_sanitize(body)
    h.sanitize(Redcarpet::Markdown.new(Redcarpet::Render::HTML, tables: true).render(body), tags: %w(p br a ul ol li strong em h3 h4 table tr td th))
  end
end
