class Outgo < Transaction
  attr_accessible :category_id, :date, :description, :tags, :user_id, :value

  belongs_to :category
  has_and_belongs_to_many :tags

end
