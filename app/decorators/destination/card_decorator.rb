class Destination::CardDecorator < ApplicationDecorator
  delegate_all

  def body
    redactor_sanitize(object.body)
  end
end
