class TailwindFormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::TagHelper

  # def tw_textarea(field, options = {})
  #   options[:class] = "#{input_class(field)} #{options[:class]} "
  #   wrapper_class = "mb-4 #{options[:wrapper_class]}"
  #   input_html = textarea(field, options)
  #
  #   content_tag(:div, class: "#{wrapper_class} #{field_id(field)}") do
  #     if options[:label] == false
  #       input_html + error_message(field) + hint_html(options)
  #     else
  #       label_html(field, options) + input_html + error_message(field) + hint_html(options)
  #     end
  #   end
  # end

  def tw_date_field(field, options = {})
    options[:class] = "#{input_class(field)} #{options[:class]}"
    input_html = date_field(field, options)

    content_tag(:div, class: "mb-4 #{field_id(field)}") do
      label_html(field, options) + input_html + error_message(field) + hint_html(options)
    end
  end

  def tw_text_field(field, options = {})
    options[:class] = "#{input_class(field)} #{options[:class]} "
    input_html = text_field(field, options)

    content_tag(:div, class: wrapper_class(field, options)) do
      field_content(field, options, input_html)
    end
  end

  def wrapper_class(field, options)
    "mb-4 #{options[:wrapper_class]} #{field_id(field)}"
  end

  def field_content(field, options, input_html)
    if options[:label] == false
      input_html + error_message(field) + hint_html(options)
    else
      label_html(field, options) + input_html + error_message(field) + hint_html(options)
    end
  end

  def tw_email_field(field, options = {})
    options[:class] = "#{input_class(field)} #{options[:class]}"
    input_html = email_field(field, options)

    content_tag(:div, class: "mb-4 #{field_id(field)}") do
      label_html(field, options) + input_html + error_message(field) + hint_html(options)
    end
  end

  def tw_password_field(field, options = {})
    options[:class] = "#{input_class(field)} #{options[:class]}"
    input_html = password_field(field, options)

    content_tag(:div, class: "mb-4 #{field_id(field)}") do
      label_html(field, options) + input_html + error_message(field) + hint_html(options)
    end
  end

  def tw_submit(value = nil, options = {})
    default_class = 'transform rounded-lg bg-blue-500 px-6 py-2 text-sm font-medium tracking-wide text-white
    transition-colors duration-300 hover:bg-blue-400 focus:outline-none focus:ring focus:ring-blue-300
    focus:ring-opacity-50'
    options[:class] = "#{default_class} #{options[:class]}".strip
    content_tag(:div, class: 'flex justify-end') do
      submit(value, options)
    end
  end

  private

  def input_class(field)
    "#{error_input_class(field)} mt-1 block w-full rounded-md border border-gray-300 px-3 py-2 shadow-sm,
     focus:border-blue-500 focus:outline-none focus:ring-blue-500"
  end

  def label_text(label_text, field)
    label_text || object&.class&.human_attribute_name(field) || I18n.t("form.fields.#{field}")
  end

  def label_html(field, options)
    label_text = label_text(options[:label], field)
    label(field, label_text, class: 'block text-sm font-medium text-gray-700')
  end

  def hint_html(options)
    return if options[:hint].blank?

    content_tag(:div, options[:hint], class: 'mt-1 text-sm text-gray-500')
  end

  # Errors
  # --------------------------------------------------------------
  def error_input_class(field)
    'border border-red-500' if object && object.errors[field].any?
  end

  def error_message(field)
    if object && object.errors[field].any?
      content_tag(:p, object.errors[field].first, class: 'text-red-600 text-sm mt-1')
    else
      ''.html_safe
    end
  end
end
