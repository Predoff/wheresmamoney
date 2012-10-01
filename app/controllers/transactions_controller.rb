class TransactionsController < ApplicationController
	respond_to :js

	def index
		@transactions = Transaction.where(user_id: 1).order('date DESC')
		@incomes = @transactions.where(type: 'Income')
    @outgoes = @transactions.where(type: 'Outgo')
  end

  def destroy
  	Transaction.destroy(params[:id])
  end
  
end
