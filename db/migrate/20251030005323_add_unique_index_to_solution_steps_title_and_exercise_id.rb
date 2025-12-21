class AddUniqueIndexToSolutionStepsTitleAndExerciseId < ActiveRecord::Migration[8.0]
  def change
    add_index :solution_steps, [:title, :exercise_id], unique: true
  end
end
