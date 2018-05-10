module SeoHelper
  # Found in the <head><title>
  def page_title
    if I18n.exists?("seo.titles.#{page_title_scope}#{controller_name}.#{action_name}")
      I18n.t("seo.titles.#{page_title_scope}#{controller_name}.#{action_name}", page_title_i18n_interpolations)
    elsif I18n.exists?("seo.titles.#{page_title_scope}#{controller_name}")
      I18n.t("seo.titles.#{page_title_scope}#{controller_name}", page_title_i18n_interpolations)
    else
      controller_name.humanize
    end
  end
end
