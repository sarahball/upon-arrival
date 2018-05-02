module FlashesHelper
  def render_flashes
    if flash.any?
      content_tag :div, class: 'alerts' do
        flash.collect do |key, value|
          content_tag :div, class: 'alert' do
            value
          end
        end.join('').html_safe
      end
    end
  end
end
