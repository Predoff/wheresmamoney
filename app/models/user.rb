# encoding: UTF-8
class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation

  attr_accessor :password
  before_save :encrypt_password

  has_many :categories
  has_many :incomes
  has_many :outgoes
  has_many :sources
  has_many :tags
  has_many :transactions

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :name
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_digest = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
	