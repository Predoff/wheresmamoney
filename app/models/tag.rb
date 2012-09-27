class Tag < ActiveRecord::Base
  attr_accessible :name, :user_id

  belongs_to :user

  has_and_belongs_to_many :outgoes
  
end
