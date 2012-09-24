class Outgo < Transaction
  attr_accessible :category_id

  belongs_to :category
  has_and_belongs_to_many :tags

end
