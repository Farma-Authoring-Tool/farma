class Educators::SolutionStepsController < Educators::BaseController
  before_action :set_lo
  before_action :set_exercise
  before_action :set_solution_step, only: [:edit, :update, :destroy]

  def index
    @solution_steps = @exercise.solution_steps.order(created_at: :asc)
  end

  def new
    @solution_step = @exercise.solution_steps.new
  end

  def edit; end

  def create
    @solution_step = @exercise.solution_steps.new(solution_step_params)

    if @solution_step.save
      redirect_to educators_lo_exercise_solution_steps_path(@lo), success: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @solution_step.update(solution_step_params)
      redirect_to educators_lo_exercise_solution_steps_path(@lo), success: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @solution_step.destroy
    redirect_to educators_lo_exercise_solution_steps_path(@lo), success: t('.success')
  end

  def duplicate
    @lo = current_user.los.find(params[:lo_id])
    @exercise = @lo.exercises.find(params[:exercise_id])
    @solution_step = @exercise.solution_steps.find(params[:id])

    duplicated_step = Duplicate::SolutionStepDuplicator.new(@solution_step).perform
    duplicated_step.exercise = @exercise
    duplicated_step.save!

    redirect_to educators_lo_exercise_solution_steps_path(@lo, @exercise),
              success: t('.duplicated', default: 'Etapa de solução duplicada com sucesso!')
  end


  private

    def set_lo
      @lo = current_user.los.find(params[:lo_id])
    end

    def set_exercise
      @exercise = @lo.exercises.find(params[:exercise_id])
    end

    def set_solution_step
      @solution_step = @exercise.solution_steps.find(params[:id])
    end

    def solution_step_params
      params.fetch(:solution_step, {}).permit(:title, :description, :response, :decimal_digits, :public)
    end

    def add_base_breadcrumbs
      add_breadcrumb I18n.t('educators.los.breadcrumbs.index'), educators_los_path
      add_breadcrumb I18n.t('educators.los.breadcrumbs.show', id: @lo.id), educators_lo_path(@lo)
      add_breadcrumb I18n.t('educators.solution_steps.breadcrumbs.index', id: @exercise.id),
                     educators_lo_exercise_solution_steps_path(@lo, @exercise)
    end

    def add_action_breadcrumbs(locale_key = nil, **i18n_opts)
      add_breadcrumb I18n.t("educators.solution_steps.breadcrumbs.#{locale_key}", **i18n_opts) if locale_key
    end

    def set_breadcrumbs
      add_base_breadcrumbs

      case action_name.to_sym
      when :index
        # noop — handled elsewhere
      when :new, :create
        add_action_breadcrumbs(:new)
      when :edit, :update
        add_action_breadcrumbs(:edit, id: @solution_step.id)
      end
    end
end
