class Button::ButtonIconComponent < ViewComponent::Base
  def initialize(actions: [])
    @actions = actions
  end
end
