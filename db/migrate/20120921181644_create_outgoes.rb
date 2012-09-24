class CreateOutgoes < ActiveRecord::Migration
  def change
    create_table :outgoes do |t|
      t.float :value
      t.date :date
      t.text :description
      t.integer :category_id
      t.integer :user_id

      t.timestamps
    end
  end
end
