class DropOutgoes < ActiveRecord::Migration
  def up
  	drop_table :outgoes
  end

  def down
  	create_table "outgoes", :force => true do |t|
	    t.float    "value"
	    t.date     "date"
	    t.text     "description"
	    t.integer  "category_id"
	    t.integer  "user_id"
	    t.datetime "created_at",  :null => false
	    t.datetime "updated_at",  :null => false
  	end
  end
end
