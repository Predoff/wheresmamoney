# encoding: UTF-8
class TransactionsController < ApplicationController
  respond_to :js

  def index
	@transactions = Transaction.where(user_id: 1).order('date DESC')
	@incomes = @transactions.where(type: 'Income')
    @outgoes = @transactions.where(type: 'Outgo')

    @date_to_show = Date.current
  end

  def destroy
  	Transaction.destroy(params[:id])
  end

end
