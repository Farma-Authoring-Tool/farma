class AddAccessibleAndDuplicableToLos < ActiveRecord::Migration[8.0]
  def change
    add_column :los, :accessible, :boolean, default: false, null: false
    add_column :los, :duplicable, :boolean, default: false, null: false
  end
end
