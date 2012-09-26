class TransactionsController < ApplicationController

	def index
    @transactions = Transaction.where(user_id: 1).order('date DESC')

    respond_to :js
  end

end
