class Income < Transaction
  attr_accessible :date, :description, :source_id, :user_id, :value

  belongs_to :user
  belongs_to :source

end