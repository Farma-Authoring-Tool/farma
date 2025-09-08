class Educators::HomeController < Educators::BaseController
  def dashboard
    @los = current_user.los
                       .includes(:picture_attachment)
                       .order(updated_at: :desc)
                       .limit(6)
  end
end
