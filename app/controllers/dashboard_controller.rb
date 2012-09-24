class DashboardController < ApplicationController
  def index
  	@categories = Category.where(user_id: 1).map { |category| category.name }
  	@tags = Tag.where(user_id: 1).map { |tag| tag.name }
  end
end
