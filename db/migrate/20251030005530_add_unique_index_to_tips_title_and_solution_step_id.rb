class AddUniqueIndexToTipsTitleAndSolutionStepId < ActiveRecord::Migration[8.0]
  def change
    add_index :tips, [:title, :solution_step_id], unique: true
  end
end
