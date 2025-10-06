class Educators::SolutionStepsController < Educators::BaseController
  before_action :set_lo
  before_action :set_exercise
  before_action :set_solution_step, only: [:show, :edit, :update, :destroy]

  def index
    @solution_steps = @exercise.solution_steps.order(created_at: :asc)
  end

  def show
  end

  def new
    @solution_step = @exercise.solution_steps.new
  end

  def create
    @solution_step = @exercise.solution_steps.new(solution_step_params)

    if @solution_step.save
      redirect_to educators_lo_path(@lo), success: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @solution_step.update(solution_step_params)
      redirect_to educators_lo_path(@lo), success: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @solution_step.destroy
    redirect_to educators_lo_path(@lo), success: t('.success')
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
      params.require(:solution_step).permit(:title, :description, :public)
    end

    def set_breadcrumbs
      add_breadcrumb I18n.t('educators.los.breadcrumbs.index'), educators_los_path

      case action_name.to_sym
      when :new, :create
        add_breadcrumb I18n.t('educators.solution_steps.breadcrumbs.new', id: @lo.id)
      when :edit, :update
        add_breadcrumb I18n.t('educators.solution_steps.breadcrumbs.edit', id: @lo.id)
      end
    end
end
