module ApplicationHelper
  def full_title(page_title = '', base_title = t('app.short_name'))
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end

  def profile_card(path:, title:, profile:)
    render Profile::ProfileComponent.new(path: path, title: title, profile: profile)
  end
end
