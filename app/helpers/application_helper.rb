module ApplicationHelper
  # ActionView::Base.default_form_builder = TailwindFormBuilder

  ActionView::Base.default_form_builder = Class.new(ActionView::Helpers::FormBuilder) do
    def input(attribute, type: :text, **options)
      @template.render Form::Input::BaseComponent.new(
        form: self,
        attribute: attribute,
        type: type,
        **options
      )
    end

    def submit(value = nil, **options)
      @template.render Form::Input::SubmitComponent.new(
        form: self,
        value: value,
        **options
      )
    end
  end

  # def rc(component_string, **args, &)
  #   component_class_name = component_string.split('\\').map(&:camelcase).join('::')
  #   component_class_name = "#{component_class_name}::Standard" unless component_class_name.include? '::'
  #
  #   render("#{component_class_name}::Component".constantize.new(**args), &)
  # end

  def full_title(page_title = '', base_title = t('app.name'))
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end
end
