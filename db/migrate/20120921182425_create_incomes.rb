class CreateIncomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|
      t.float :value
      t.date :date
      t.text :description
      t.integer :source_id
      t.integer :user_id

      t.timestamps
    end
  end
end
