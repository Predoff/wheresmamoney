class OutgoesController < ApplicationController

  def create
    value = params[:outgo][:value].gsub(',', '.')
    date = Date.parse(params[:outgo][:date])
    description = params[:outgo][:description]
    current_user = User.first
    category_id = params[:outgo][:category_id]

    tags = params[:outgo][:tags].split(',').map { |name| current_user.tags.find_or_create_by_name name }

    @outgo = current_user.outgoes.build( value: value, date: date, description: description, category_id: category_id, tags: tags )
  	@outgo.save
  end
end
