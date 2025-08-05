module ApplicationHelper
  def full_title(page_title = '', base_title = t('app.name'))
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end
end
