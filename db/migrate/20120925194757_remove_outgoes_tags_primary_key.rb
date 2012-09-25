class RemoveOutgoesTagsPrimaryKey < ActiveRecord::Migration
  def change
  	remove_column :outgoes_tags, :id
  end
end
