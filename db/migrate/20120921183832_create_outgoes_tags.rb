class CreateOutgoesTags < ActiveRecord::Migration
  def change
  	create_table :outgoes_tags do |t|
  		t.references :outgo
  		t.references :tag
  	end 
  end
end
