class Educators::HomeController < Educators::BaseController
  def dashboard
    @los = current_user.los.order(created_at: :desc)
  end
end
