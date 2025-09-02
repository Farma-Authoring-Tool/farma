class Form::Input::CheckboxComponent < ViewComponent::Base
  def initialize(form:, attribute:, label: nil, **options)
    super()
    @form = form
    @attribute = attribute
    @label = label || @attribute.to_s.humanize
    @options = options
  end

  def call
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

    def label
      @form.label(
        @attribute,
        @label,
        class: 'text-xs md:text-sm font-medium text-gray-700 cursor-pointer'
      )
    end
end
