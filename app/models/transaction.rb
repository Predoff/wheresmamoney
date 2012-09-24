class Transaction < ActiveRecord::Base
  attr_accessible :value, :date, :description, :user_id

  belongs_to :user

end
