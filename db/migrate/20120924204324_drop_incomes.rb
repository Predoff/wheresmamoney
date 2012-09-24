class DropIncomes < ActiveRecord::Migration
  def up
  	drop_table :incomes
  end

  def down
  	create_table "incomes", :force => true do |t|
	    t.float    "value"
	    t.date     "date"
	    t.text     "description"
	    t.integer  "source_id"
	    t.integer  "user_id"
	    t.datetime "created_at",  :null => false
	    t.datetime "updated_at",  :null => false
  	end
  end
end
