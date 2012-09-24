class DashboardController < ApplicationController
  def index
  	@user = User.find(1)
  	@categories = Category.where(user_id: 1).order('name')
  	@tags = Tag.where(user_id: 1).order(:name).map { |tag| tag.name }
  end
end
