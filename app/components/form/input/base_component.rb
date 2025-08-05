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
    classes = 'mt-1 block w-full rounded-md border border-gray-300 px-3 py-2 shadow-sm focus:border-blue-500 focus:outline-none focus:ring-blue-500'
    classes += " #{error_input_class}"

    @form.send(input_type, @attribute, class: classes, id: id, **@options) + error_message
  end

  def label
    content_tag :label, class: 'block text-sm font-medium text-gray-700', for: id do
      @object.class.human_attribute_name(@attribute)
    end
  end

  def hint
    content_tag :p, @options[:hint], class: 'mt-1 text-xs text-gray-500' if @options[:hint].present?
  end

  private

  def input_type
    "#{@type}_field"
  end

  # Errors
  # --------------------------------------------------------------
  def error_input_class
    'border border-red-500' if has_errors?
  end

  def error_message
    return unless has_errors?

    content_tag(:p, @object.errors[@attribute].join('<br>'), class: 'text-red-600 text-sm mt-1')
  end

  def has_errors?
    @object && @object.errors[@attribute].any?
  end
end
