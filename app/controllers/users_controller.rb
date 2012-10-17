# encoding: UTF-8
class UsersController < ApplicationController
	skip_before_filter :require_authentication, :only => [:create, :login, :welcome]

	def create
		@user = User.new(params[:user])
		if @user.save
			redirect_to root_url, :notice => "Cadastrado"
		else
			render "new"
		end
	end

	def login
		user = User.authenticate(params[:email], params[:password])
	  if user
	    session[:user_id] = user.id
	    redirect_to root_url
	  else
	    redirect_to welcome_path
	  end
	end

	def logout
		session[:user_id] = nil
		redirect_to welcome_path
	end

	def welcome
		@new_user = User.new
		@user = current_user
	end

end
