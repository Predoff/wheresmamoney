class Income < ActiveRecord::Base
  attr_accessible :date, :description, :source_id, :user_id, :value

  belongs_to :source
  belongs_to :user

end
