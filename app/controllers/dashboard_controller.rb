class DashboardController < ApplicationController
  def index
  	@user_name = current_user.name
  	@categories = current_user.categories.order('name')
  	@sources = current_user.sources.order('name')
  	@tags = current_user.tags.order(:name).map { |tag| tag.name }
  end
end
