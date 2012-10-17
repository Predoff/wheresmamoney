# encoding: UTF-8
class UsersController < ApplicationController

	def create
		@user = User.new(params[:user])
		if @user.save
			redirect_to root_url, :notice => "Cadastrado"
		else
			render "new"
		end
	end

	def welcome
		@new_user = User.new
		@user = current_user
	end

end
