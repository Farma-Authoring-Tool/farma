class Button::User::Component < ViewComponent::Base
  include IconsHelper

  def initialize(path:, text: '', classes: '', icon: '')
    super
    @path = path
    @text = text
    @icon = icon
  end
end
