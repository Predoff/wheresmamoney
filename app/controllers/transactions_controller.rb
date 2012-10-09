# encoding: UTF-8
class TransactionsController < ApplicationController
	respond_to :js

	def index
		@transactions = Transaction.where(user_id: 1).order('date DESC')
		@incomes = @transactions.where(type: 'Income').includes(:source)
    @outgoes = @transactions.where(type: 'Outgo').includes(:tags, :category)

    @months = { :'1' => 'Janeiro', :'2' => 'Fevereiro', :'3' => 'Março', :'4' => 'Abril', :'5' => 'Maio', :'6' => 'Junho', :'7' => 'Julho', :'8' => 'Agosto', :'9' => 'Setembro', :'10' => 'Outubro', :'11' => 'Novembro', :'12' => 'Dezembro'}

    @month_to_show = params[:'selected-month'] || Date.today.month
    @year_to_show = params[:'selected-year'] || Date.today.year

    # if stale? (:etag => [objeto1, objeto2]) 
    #(:last_modified => objeto.updated_at.udt)
    #
    #(:etag => objetoactiverecord_que eu quero saber se mudou alguma coisa ou não)

    # fresh_when (:etag => objetoactiverecord_que eu quero saber se mudou alguma coisa ou não)

    
  end

  def destroy
  	Transaction.destroy(params[:id])
  end
  
end
