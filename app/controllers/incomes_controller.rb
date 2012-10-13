class IncomesController < ApplicationController
	
  def create
    params[:income][:value] = params[:income][:value].gsub(',', '.')

    @income = current_user.incomes.build(params[:income])
    @income.save
  end
end
