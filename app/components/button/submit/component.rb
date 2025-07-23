class Button::Submit::Component < ViewComponent::Base
  def initialize(text:, path: nil, type: 'submit', classes: '')
    super
    @text = text
    @type = type
    @classes = classes
  end
end
