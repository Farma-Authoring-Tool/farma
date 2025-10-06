class Button::FabComponent < ViewComponent::Base
  def initialize(actions: [])
    @actions = actions
  end
end
