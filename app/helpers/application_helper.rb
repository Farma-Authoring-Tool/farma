module ApplicationHelper
  def button_link_to(name, path, options = {})
    default_classes = "bg-green-600 hover:bg-green-950 text-white font-bold py-2 px-6 rounded-md transition duration-800"
    options[:class] = [default_classes, options[:class]].compact.join(" ")
    link_to name, path, options
  end
end