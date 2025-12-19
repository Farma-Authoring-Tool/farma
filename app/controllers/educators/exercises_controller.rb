class Educators::ExercisesController < Educators::BaseController
  before_action :set_lo
  before_action :set_exercise, only: [:edit, :update, :destroy, :duplicate]

  def new
    @exercise = @lo.exercises.build
  end

  def edit; end

  def create
    @exercise = @lo.exercises.new(exercise_params)

    if @exercise.save
      redirect_to educators_lo_path(@lo), success: t('.success')
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @exercise.update(exercise_params)
      redirect_to educators_lo_path(@lo), success: t('.success')
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @exercise.destroy
    redirect_to educators_lo_path(@lo), success: t('.success')
  end

  def duplicate
    @exercise.duplicate
    redirect_to educators_lo_path(@lo), success: t('.success')
  end

  private

    def set_lo
      @lo = current_user.los.find(params[:lo_id])
    end

    def set_exercise
      @exercise = @lo.exercises.find(params[:id])
    end

    def exercise_params
      params.fetch(:exercise, {}).permit(:title, :description, :public)
    end

    def set_breadcrumbs
      case action_name.to_sym
      when :new, :create
        add_breadcrumb I18n.t('educators.los.breadcrumbs.index'), educators_los_path
        add_breadcrumb I18n.t('educators.los.breadcrumbs.show', id: @lo.id), educators_lo_path(@lo)
        add_breadcrumb I18n.t('educators.exercises.breadcrumbs.new')
      when :edit, :update
        add_breadcrumb I18n.t('educators.los.breadcrumbs.index'), educators_los_path
        add_breadcrumb I18n.t('educators.los.breadcrumbs.show', id: @lo.id), educators_lo_path(@lo)
        add_breadcrumb I18n.t('educators.exercises.breadcrumbs.edit', id: @exercise.id)
      end
    end
end
