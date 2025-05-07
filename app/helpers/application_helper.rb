module ApplicationHelper
  ActionView::Base.default_form_builder = TailwindFormBuilder

  def button_link_to(name, path, options = {})
    default_classes = "bg-green-600 hover:bg-green-950 text-white font-bold py-2 px-6 rounded-md transition duration-800"
    options[:class] = [default_classes, options[:class]].compact.join(" ")
    link_to name, path, options
  end

  def rc(component_string, **args, &block)
    component_class_name = component_string.split("\\").map(&:camelcase).join("::")

    unless component_class_name.include? "::"
      component_class_name = "#{component_class_name}::Standard"
    end

    render "#{component_class_name}::Component".constantize.new(**args), &block
  end
end