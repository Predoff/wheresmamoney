class Income < Transaction
  attr_accessible :source_id

  belongs_to :source

end
