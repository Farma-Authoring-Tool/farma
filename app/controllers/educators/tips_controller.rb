class Educators::TipsController < Educators::BaseController
  before_action :set_lo
  before_action :set_exercise
  before_action :set_solution_step
  before_action :set_tip, only: [:edit, :update, :destroy]

  def index
    @tips = @solution_step.tips.order(created_at: :asc)
  end

  def new
    @tip = @solution_step.tips.new
  end

  def create
    @tip = @solution_step.tips.new(tip_params)

    if @tip.save
      redirect_to educators_lo_exercise_solution_steps_path(@lo), success: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @tip.update(tip_params)
      redirect_to educators_lo_exercise_solution_steps_path(@lo), success: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tip.destroy
    redirect_to educators_lo_exercise_solution_steps_path(@lo), success: t('.success')
  end

  private 
    def tip_params
      params.fetch(:tip, {}).permit(:title, :description, :number_attempts)
    end

    def set_lo
      @lo = current_user.los.find(params[:lo_id])
    end

    def set_exercise
      @exercise = @lo.exercises.find(params[:exercise_id])
    end

    def set_solution_step
      @solution_step = @exercise.solution_steps.find(params[:solution_step_id])
    end

    def set_tip
      @tip = @solution_step.tips.find(params[:id])
    end

    def add_base_breadcrumbs
      add_breadcrumb I18n.t('educators.los.breadcrumbs.index'), educators_los_path
      add_breadcrumb I18n.t('educators.los.breadcrumbs.show', id: @lo.id), educators_lo_path(@lo)
      add_breadcrumb I18n.t('educators.solution_steps.breadcrumbs.index' , id: @exercise.id),
                educators_lo_exercise_solution_steps_path(@lo, @exercise)
    end

    def add_action_breadcrumbs(locale_key = nil, **i18n_opts)
      add_breadcrumb I18n.t("educators.tips.breadcrumbs.#{locale_key}", **i18n_opts) if locale_key
    end

    def set_breadcrumbs
      add_base_breadcrumbs

      case action_name.to_sym
      when :index
      when :new, :create
        add_action_breadcrumbs(:new)
      when :edit, :update
        add_action_breadcrumbs(:edit, id: @tip.id)
      end
    end
end
