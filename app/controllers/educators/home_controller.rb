class Educators::HomeController < Educators::BaseController
  def dashboard
    @los = current_user.los
              .includes(:picture_attachment)
              .order(created_at: :desc)
  end
end
