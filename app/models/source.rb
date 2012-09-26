class Source < ActiveRecord::Base
  attr_accessible :name, :user_id

  has_many :incomes
end
