class ApplicationDecorator < Draper::Decorator
  
  private
  def redactor_sanitize(body)
    h.sanitize(body, tags: %w(p br a ul ol li strong em))
  end
end
