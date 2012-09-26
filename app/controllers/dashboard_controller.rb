class DashboardController < ApplicationController
  def index
  	@user = User.find(1)
  	@categories = Category.where(user_id: @user.id).order('name')
  	@sources = Source.where(user_id: @user.id).order('name')
  	@tags = Tag.where(user_id: @user.id).order(:name).map { |tag| tag.name }
  	@today = "#{Date.today.day}/#{Date.today.month}/#{Date.today.year}"
  end
end
