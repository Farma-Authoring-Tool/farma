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
end
