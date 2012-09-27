class TransactionsController < ApplicationController
	respond_to :js

	def index
		@transactions = Transaction.where(user_id: 1).order('date DESC')
    @transactions = @transactions.where(type: params[:type]) if params[:type]
  end

  def destroy
  	Transaction.destroy(params[:id])
  end
  
end
