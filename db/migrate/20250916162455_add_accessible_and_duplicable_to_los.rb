class AddAccessibleAndDuplicableToLos < ActiveRecord::Migration[8.0]
  def change
    change_table :los, bulk: true do |t|
      t.boolean :accessible, default: false, null: false
      t.boolean :duplicable, default: false, null: false
    end
  end
end
