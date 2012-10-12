class OutgoesController < ApplicationController

  def create
    params[:outgo][:value] = params[:outgo][:value].gsub(',', '.')
    params[:outgo][:tags] = params[:outgo][:tags].split(',').map { |name| current_user.tags.find_or_create_by_name name }

    @outgo = current_user.outgoes.build(params[:outgo])
  	@outgo.save
  end
end
