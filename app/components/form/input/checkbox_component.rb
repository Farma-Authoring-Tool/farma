class Form::Input::CheckboxComponent < Form::Input::BaseComponent
  def initialize(form:, attribute:, label: nil, **options)
    options[:label] = false
    super(form: form, attribute: attribute, type: :checkbox, label: label, **options)
  end

  def input
    content_tag :div, class: 'flex items-center space-x-2 mb-5' do
      checkbox_field + label
    end
  end

  private

    def checkbox_field
      @form.check_box(
        @attribute,
        class: 'h-4 w-4 rounded border-gray-300 text-green-600 focus:outline-none focus:ring-0',
        **@options
      )
    end
end
