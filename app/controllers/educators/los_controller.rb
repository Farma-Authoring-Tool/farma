class Educators::LosController < Educators::BaseController
  def show
    @lo = current_user.los.find(params[:id])
  end

  def new
    @lo = Lo.new
  end

  def create
    @lo = current_user.los.new(lo_params)

    if @lo.save
      redirect_to educators_root_path, notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @lo = current_user.los.find(params[:id])
    @lo.destroy
    redirect_to educators_root_path, notice: t('.success')
  end

  def edit
    @lo = current_user.los.find(params[:id])
  end

  def update
    @lo = current_user.los.find(params[:id])

    if @lo.update(lo_params)
      redirect_to educators_root_path, notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end


  private

    def lo_params
      params.expect(lo: [:title, :description, :picture])
    end
end
