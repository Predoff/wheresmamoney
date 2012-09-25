class OutgoesController < ApplicationController
	def new
		@outgoes = Outgo.new
	end
end
