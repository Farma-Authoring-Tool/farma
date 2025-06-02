class Button::Primary::Component < ViewComponent::Base
  def initialize(text:, path: nil, type: 'link', classes: '')
    super
    @path = path
    @text = text
    @type = type
    @classes = classes
  end
end
