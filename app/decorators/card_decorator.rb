class CardDecorator < ApplicationDecorator
  delegate_all

  def body
    markdown_sanitize(object.body)
  end
end
