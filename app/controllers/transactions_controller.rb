# encoding: UTF-8
class TransactionsController < ApplicationController
	respond_to :js

	def index
		@transactions = Transaction.where(user_id: 1).order('date DESC')
		@incomes = @transactions.where(type: 'Income')
    @outgoes = @transactions.where(type: 'Outgo')

    #@months = ['Janeiro', 'Fevereiro', 'Marco', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro']
    @months = { :'1' => 'Janeiro', :'2' => 'Fevereiro', :'3' => 'Março', :'4' => 'Abril', :'5' => 'Maio', :'6' => 'Junho', :'7' => 'Julho', :'8' => 'Agosto', :'9' => 'Setembro', :'10' => 'Outubro', :'11' => 'Novembro', :'12' => 'Dezembro'}
  	#Março não funciona porque é UTF-8. Tem que arrumar isso.

    if params[:'selected-month']
      @month_to_show = params[:'selected-month']
    else
      @month_to_show = Date.today.month
    end

    if params[:'selected-year'] 
      @year_to_show = params[:'selected-year']
    else
      @year_to_show = Date.today.year
    end

  end

  def destroy
  	Transaction.destroy(params[:id])
  end
  
end
