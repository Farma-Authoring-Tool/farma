class Api::Professors::SolutionStepsController < Api::BaseController
  include FindResources

  before_action :find_solution_step, except: [:create, :index, :reorder]

  def index
    render json: @exercise.solution_steps
  end

  def show
    render json: @solution_step
  end

  def create
    solution_step = @exercise.solution_steps.new(solution_steps_params)

    if solution_step.save
      render json: { message: success_create_message, solution_step: solution_step }, status: :created
    else
      render json: {
        message: error_message,
        solution_step: solution_step,
        errors: solution_step.errors
      }, status: :unprocessable_entity
    end
  end

  def update
    if @solution_step.update(solution_steps_params)
      render json: { message: success_update_message, solution_step: @solution_step }, status: :accepted
    else
      render json: {
        message: error_message,
        solution_step: @solution_step,
        errors: @solution_step.errors
      }, status: :unprocessable_entity
    end
  end

  def destroy
    @solution_step.destroy
    render json: { message: success_destroy_message }, status: :accepted
  rescue StandardError
    render json: { message: unsuccess_destroy_message }, status: :unprocessable_entity
  end

  def duplicate
    duplicated_solution_step = @solution_step.duplicate
    render json: { message: feminine_success_duplicate_message(model: SolutionStep),
                   solution_step: duplicated_solution_step }, status: :created
  end

  def reorder
    @exercise.reorder_solution_steps(params[:solution_steps_ids])
    render json: { message: success_reorder_message(model: SolutionStep) }, status: :ok
  end

  private

  def solution_steps_params
    params.expect(solution_step: [:title, :description, :response, :decimal_digits, :public, :tips_display_mode])
  end

  def find_solution_step
    @solution_step = @exercise.solution_steps.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: resource_not_found_message(model: e.model) }, status: :not_found
  end
end
