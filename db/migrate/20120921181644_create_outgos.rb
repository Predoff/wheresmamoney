class CreateOutgos < ActiveRecord::Migration
  def change
    create_table :outgos do |t|
      t.float :value
      t.date :date
      t.text :description
      t.integer :category_id
      t.integer :user_id

      t.timestamps
    end
  end
end
