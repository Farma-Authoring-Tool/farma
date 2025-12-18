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
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @lo = current_user.los.find(params[:id])

    if @lo.update(lo_params)
      redirect_to educators_root_path, success: t('.success')
    else
      render :edit, status: :unprocessable_entity
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
    duplicated_lo = Duplicate::LoDuplicator.new(@lo).perform
    redirect_to educators_lo_path(duplicated_lo), success: t('.duplicated', default: 'LO duplicado com sucesso!')
  end

  private

    def lo_params
      params.fetch(:lo, {}).permit(:title, :description, :picture, :accessible, :duplicable)
    end

    def add_lo_breadcrumbs(action_name, **i18n_opts)
      add_breadcrumb I18n.t('educators.los.breadcrumbs.index'), educators_los_path
      add_breadcrumb I18n.t("educators.los.breadcrumbs.#{action_name}", **i18n_opts)
    end

    def set_breadcrumbs
      case action_name.to_sym
      when :index
        add_breadcrumb I18n.t('educators.los.breadcrumbs.index')
      when :new, :create
        add_lo_breadcrumbs(:new)
      when :show
        add_lo_breadcrumbs(:show, id: @lo.id)
      when :edit, :update
        add_lo_breadcrumbs(:edit, id: @lo.id)
      end
    end
end
