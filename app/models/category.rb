class Category < ActiveRecord::Base
  attr_accessible :name, :user_id

  has_many :outgoes
end
