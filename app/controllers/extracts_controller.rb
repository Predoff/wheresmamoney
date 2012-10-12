class ExtractsController < ApplicationController
	respond_to :js
	
	def by_month
	end

	def by_year
	end

	def custom
	end

	def index
		@user_name = current_user.name
  	@categories = current_user.categories.order('name')
  	@sources = current_user.sources.order('name')
  	@tags = current_user.tags.order(:name).map { |tag| tag.name }
	end

	def recent
	end
end
