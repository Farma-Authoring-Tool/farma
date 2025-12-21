class AddUniqueIndexToIntroductionsTitleAndLoId < ActiveRecord::Migration[8.0]
  def change
    add_index :introductions, [:title, :lo_id], unique: true
  end
end
