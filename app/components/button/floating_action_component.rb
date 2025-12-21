class Button::FloatingActionComponent < ViewComponent::Base
  def initialize(actions: [])
    @actions = actions
  end
end
