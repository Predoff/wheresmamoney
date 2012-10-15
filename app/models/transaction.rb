class Transaction < ActiveRecord::Base
  attr_accessible :value, :date, :description, :user_id

  belongs_to :user

  scope :income, where(type: "Income")
  scope :outgo, where(type: "Outgo")

  def self.by_month(date)
  	where(date: date.beginning_of_month..date.end_of_month)
  end

  def self.by_year(date)
  	where(date: date.beginning_of_year..date.end_of_year)
  end

end
