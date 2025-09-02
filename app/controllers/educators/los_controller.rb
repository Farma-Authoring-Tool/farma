class Educators::LosController < Educators::BaseController
  def show
    @lo = Lo.find(params[:id])
  end

  def new
    @lo = Lo.new
  end

  def create
    @lo = Lo.new(lo_params)
    @lo.user = current_user

    if @lo.save
      redirect_to educators_root_path, notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def lo_params
      params.expect(lo: [:title, :description, :picture])
    end
end
