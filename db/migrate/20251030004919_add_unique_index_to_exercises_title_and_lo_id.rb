class AddUniqueIndexToExercisesTitleAndLoId < ActiveRecord::Migration[8.0]
  def change
    add_index :exercises, [:title, :lo_id], unique: true
  end
end
