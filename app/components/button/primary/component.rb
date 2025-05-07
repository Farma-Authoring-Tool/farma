class Button::Primary::Component < ViewComponent::Base
  def initialize(path: nil, text:, type: "link", classes: "")
    @path = path
    @text = text
    @type = type
    @classes = classes
  end
end