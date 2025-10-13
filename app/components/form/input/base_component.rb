# frozen_string_literal: true

class Form::Input::BaseComponent < ViewComponent::Base
  def initialize(form:, attribute:, type:, **options)
    @object = form.object
    @form = form
    @attribute = attribute
    @type = type
    @options = options
  end

  def id
    class_name = @object.class.name.underscore.downcase
    "#{class_name}_#{@attribute}"
  end

  def input
    classes = 'text-xs text-gray-800 md:text-base mt-1 block w-full border-0 border-b border-gray-300'
    classes += 'py-1 px-3 focus:outline-none focus:ring-0'
    classes += " #{error_input_class}"

    @form.send(input_type, @attribute, class: classes, id: id, **@options)
  end

  def label
    content_tag :label, class: 'block text-xs md:text-sm font-medium text-gray-700', for: id do
      @object.class.human_attribute_name(@attribute)
    end
  end

  def hint
    content_tag :p, @options[:hint], class: 'mt-1 text-xs text-gray-500' if @options[:hint].present?
  end

  private

    def input_type
      { 'text_area' => 'text_area', 'checkbox' => 'check_box', 'number' => 'number' }[@type.to_s] || "#{@type}_field"
    end

    # Errors
    # --------------------------------------------------------------
    def error_input_class
      'border border-red-500' if errors?
    end

    def error_message
      return unless errors?

      content_tag(:p,
                  helpers.sanitize_text(@object.errors[@attribute].join('<br>')),
                  class: 'text-red-600 text-xs md:text-sm mt-1')
    end

    def errors?
      @object && @object.errors[@attribute].any?
    end
end
