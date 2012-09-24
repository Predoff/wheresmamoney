class DashboardController < ApplicationController
  def index
  	@categories = Category.all.map { |category| category.name }
  	@tags = Tag.all.map { |tag| tag.name }
  end
end
