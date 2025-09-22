class Educators::IntroductionsController < Educators::BaseController
  def new
    @lo = current_user.los.find(params[:lo_id])
    @introduction = @lo.introductions.build
  end

  def edit
    @lo = current_user.los.find(params[:lo_id])
    @introduction = @lo.introductions.find(params[:id])
  end

  def create
    @lo = current_user.los.find(params[:lo_id])
    @introduction = @lo.introductions.new(introduction_params)

    if @introduction.save
      redirect_to educators_lo_path(@lo), success: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @lo = current_user.los.find(params[:lo_id])
    @introduction = @lo.introductions.find(params[:id])

    if @introduction.update(introduction_params)
      redirect_to educators_lo_path(@lo), success: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @lo = current_user.los.find(params[:lo_id])
    @introduction = @lo.introductions.find(params[:id])

    @introduction.destroy

    redirect_to educators_lo_path(@lo), success: t('.success')
  end

  private

    def introduction_params
      params.fetch(:introduction, {}).permit(:title, :description, :public)
    end

    def set_breadcrumbs
      case action_name.to_sym
      when :new, :create
        add_breadcrumb I18n.t('educators.los.breadcrumbs.index'), educators_los_path
        add_breadcrumb I18n.t('educators.introductions.breadcrumbs.new', id: @lo.id)
      when :edit, :update
        add_breadcrumb I18n.t('educators.los.breadcrumbs.index'), educators_los_path
        add_breadcrumb I18n.t('educators.introductions.breadcrumbs.edit', id: @lo.id)
      end
    end
end
