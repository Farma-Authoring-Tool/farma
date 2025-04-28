class Button::Primary::Component < ViewComponent::Base
  def initialize(path:, text:, classes: "")
    @path = path
    @text = text
  end
end
