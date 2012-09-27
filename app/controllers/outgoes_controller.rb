class OutgoesController < ApplicationController

  def create
    value = params[:outgo][:value].gsub(',', '.')
    date = Date.parse(params[:outgo][:date])
    description = params[:outgo][:description]
    user_id = 1
    category_id = params[:outgo][:category_id]

    tags = params[:outgo][:tags].split(',').map { |name| Tag.find_or_create_by_name name }

    @outgo = Outgo.new( value: value, date: date, description: description, category_id: category_id, user_id: user_id, tags: tags )
  	@outgo.save
  end
end
