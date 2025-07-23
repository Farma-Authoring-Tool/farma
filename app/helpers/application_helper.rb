module ApplicationHelper
  ActionView::Base.default_form_builder = TailwindFormBuilder

  def rc(component_string, **args, &)
    component_class_name = component_string.split('\\').map(&:camelcase).join('::')

    component_class_name = "#{component_class_name}::Standard" unless component_class_name.include? '::'

    render("#{component_class_name}::Component".constantize.new(**args), &)
  end

  def full_title(page_title = '', base_title = t('app.name'))
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end
end
