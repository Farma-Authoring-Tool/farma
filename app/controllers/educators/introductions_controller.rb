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
  end

  def update
    if @introduction.update(introduction_params)
      redirect_to educators_lo_path(@lo), success: t('.success')
    end
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

    def add_lo_breadcrumbs(locale_key, **i18n_opts)
      add_breadcrumb I18n.t('educators.los.breadcrumbs.index'), educators_los_path
      add_breadcrumb I18n.t("educators.los.breadcrumbs.show", id: @lo.id), educators_lo_path(@lo)
      add_breadcrumb I18n.t("educators.introductions.breadcrumbs.#{locale_key}", **i18n_opts)
    end

    def set_breadcrumbs
      case action_name.to_sym
      when :new, :create
        add_lo_breadcrumbs(:new)
      when :edit, :update
        add_breadcrumb I18n.t("educators.los.breadcrumbs.show", id: @lo.id), educators_lo_path(@lo)
        add_lo_breadcrumbs(:edit, id: @introduction.id)
      end
    end
end