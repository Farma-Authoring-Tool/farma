class Educators::LosController < Educators::BaseController
  def index
    @los = current_user.los
                       .includes(:picture_attachment)
                       .order(created_at: :desc)
  end

  def show
    @lo = current_user.los.find(params[:id])
  end

  def new
    @lo = current_user.los.new
  end

  def edit
    @lo = current_user.los.find(params[:id])
  end

  def create
    @lo = current_user.los.new(lo_params)

    if @lo.save
      redirect_to educators_root_path, success: t('.success')
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    @lo = current_user.los.find(params[:id])

    if @lo.update(lo_params)
      redirect_to educators_root_path, success: t('.success')
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @lo = current_user.los
                      .includes(introductions: :introductions_visualizations)
                      .find(params[:id])
    @lo.destroy!

    redirect_to educators_los_path, success: t('.success')
  end

  def duplicate
    @lo = current_user.los.find(params[:id])
    duplicated_lo = @lo.duplicate
    redirect_to educators_lo_path(duplicated_lo), success: t('.success')
  end

  private

    def lo_params
      params.fetch(:lo, {}).permit(:title, :description, :picture, :accessible, :duplicable)
    end

    def set_breadcrumbs
      case action_name.to_sym
      when :index
        add_breadcrumb I18n.t('educators.los.breadcrumbs.index'), educators_los_path
      when :new, :create
        add_breadcrumb I18n.t('educators.los.breadcrumbs.index'), educators_los_path
        add_breadcrumb I18n.t('educators.los.breadcrumbs.new')
      when :show
        add_breadcrumb I18n.t('educators.los.breadcrumbs.index'), educators_los_path
        add_breadcrumb I18n.t('educators.los.breadcrumbs.show', id: @lo.id)
      when :edit, :update
        add_breadcrumb I18n.t('educators.los.breadcrumbs.index'), educators_los_path
        add_breadcrumb I18n.t('educators.los.breadcrumbs.show', id: @lo.id), educators_lo_path(@lo)
        add_breadcrumb I18n.t('educators.los.breadcrumbs.edit')
      end
    end
end
