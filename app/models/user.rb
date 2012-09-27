class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

  has_many :categories
  has_many :incomes
  has_many :outgoes
  has_many :sources
  has_many :tags
end
	