class CreateOutgoesTags < ActiveRecord::Migration
  def change
  	create_table :outgoes_tags do |t|
  		t.references :outgoes
  		t.references :tags
  	end 
  end
end
