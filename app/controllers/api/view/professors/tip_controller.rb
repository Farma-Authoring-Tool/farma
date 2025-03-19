class Api::View::Professors::TipController < Api::BaseController
  before_action :set_solution_step

  def available_tip
    tip = @solution_step.unviewed_tip(current_user, nil)
    tip&.view(current_user, nil)

    render json: tip, status: :ok
  end

  private

  def set_solution_step
    lo = current_user.los.find(params[:id])
    exercise = lo.exercises.find(params[:exercise_id])
    @solution_step = exercise.solution_steps.find(params[:solution_step_id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: resource_not_found_message(model: e.model) }, status: :not_found
  end
end
