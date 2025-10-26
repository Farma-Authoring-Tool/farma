class Button::FloatingActionComponent < ViewComponent::Base
  def initialize(actions: [])
    super()
    @actions = actions
  end
end
