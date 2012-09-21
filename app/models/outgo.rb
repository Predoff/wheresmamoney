class Outgo < ActiveRecord::Base
  attr_accessible :category_id, :date, :description, :float, :user_id, :value

  belongs_to :category
  belongs_to :user
  has_and_belongs_to_many :tags

end
