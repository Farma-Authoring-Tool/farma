class Educators::IntroductionsController < Educators::BaseController

  before_action :set_lo
  before_action :set_introduction, only: [:edit, :update, :destroy]

  def new
    @introduction = @lo.introductions.build
  end

  def edit; end

  def create
    @introduction = @lo.introductions.new(introduction_params)

    if @introduction.save
      redirect_to educators_lo_path(@lo), success: t('.success')
  end

  def update
    if @introduction.update(introduction_params)
      redirect_to educators_lo_path(@lo), success: t('.success')
  end

  def destroy
    @introduction.destroy
    redirect_to educators_lo_path(@lo), success: t('.success')
  end

  private

    def set_lo
      @lo = current_user.los.find(params[:lo_id])
    end

    def set_introduction
      @introduction = @lo.introductions.find(params[:id])
    end

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