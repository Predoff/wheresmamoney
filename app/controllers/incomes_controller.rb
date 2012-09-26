class IncomesController < ApplicationController
	def create
    value = params[:income][:value].gsub(',', '.')
    date = params[:income][:date]
    description = params[:income][:description]
    user_id = 1
    source_id = params[:income][:source_id]

    @income = Income.new( value: value, date: date, description: description, source_id: source_id, user_id: user_id )
  	@income.save
  end	
end