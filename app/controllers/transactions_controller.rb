# encoding: UTF-8
class TransactionsController < ApplicationController
  respond_to :js

  def index
	@transactions = Transaction.where(user_id: 1).order('date DESC')
	@incomes = @transactions.where(type: 'Income')
    @outgoes = @transactions.where(type: 'Outgo')

    if params[:date_action] == "previous"
      date = params[:date].to_date - 1.month
    elsif params[:date_action] == "next"
      date = params[:date].to_date + 1.month
    end

    @date_to_show = date || Date.current
  end

  def destroy
  	Transaction.destroy(params[:id])
  end

end
