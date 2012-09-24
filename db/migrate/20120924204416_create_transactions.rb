class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
    	t.integer  "user_id"
    	t.date     "date"
    	t.float    "value"
	    t.text     "description"
	    t.type     "type"
	    t.integer  "source_id"
	    t.integer  "category_id"
      t.timestamps
    end
  end
end
