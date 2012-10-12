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
		@incomes = current_user.incomes.limit(12).group_by(&:date)
		@outgoes = current_user.outgoes.limit(12).group_by(&:date)
		@transactions = Transaction.where(user_id: current_user.id).limit(12).group_by(&:date)
	end
end
