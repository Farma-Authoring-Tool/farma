class Button::ButtonIconComponent < ViewComponent::Base
  def initialize(actions: [])
    super()
    @actions = actions
  end
end
  