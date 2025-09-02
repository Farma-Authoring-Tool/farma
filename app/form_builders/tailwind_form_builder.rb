class TailwindFormBuilder < ActionView::Helpers::FormBuilder
  def input(attribute, type: :text, **)
    @template.render Form::Input::BaseComponent.new(
      form: self,
      attribute: attribute,
      type: type,
      **
    )
  end

  def submit(value = nil, **)
    @template.render Form::Input::SubmitComponent.new(
      form: self,
      value: value,
      **
    )
  end

  def full_error(attribute)
    return unless object && object.errors[attribute].any?

    @template.content_tag(
      :p,
      object.errors.full_messages_for(attribute).join(', '),
      class: 'text-xs md:text-sm text-red-600 pl-0 p-2'
    )
  end

  def file_input(attribute, **)
    @template.render Form::Input::FileComponent.new(
      form: self,
      attribute: attribute,
      **
    )
  end

  def checkbox(attribute, **)
    @template.render Form::Input::CheckboxComponent.new(
      form: self,
      attribute: attribute,
      **
    )
  end
end
