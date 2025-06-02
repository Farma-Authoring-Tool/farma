class Button::Standard::Component < ViewComponent::Base
  def initialize(path:, text:, classes: '')
    super
    @path = path
    @text = text
  end
end
