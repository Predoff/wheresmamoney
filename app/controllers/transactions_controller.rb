# encoding: UTF-8
class TransactionsController < ApplicationController
  respond_to :js

	def index
    #@incomes = Income.includes(:source)
    #@outgoes = Outgo.includes(:tags, :category)
    #@transactions = @outgoes + @incomes
    
  	@transactions = Transaction.where(user_id: 1).order('date DESC')
  	@incomes = @transactions.where(type: 'Income')
    @outgoes = @transactions.where(type: 'Outgo')

    @date_to_show = Date.current
    #@month_to_show = params[:'selected-month'] || Date.today.month
    #@year_to_show = params[:'selected-year'] || Date.today.year
  end

  def destroy
  	Transaction.destroy(params[:id])
  end

end

# Examinar se se aplica ao meu sistema esse tipo de funcionalidade e implementar
#
# if stale? (:etag => [objeto1, objeto2]) 
# (:last_modified => objeto.updated_at.udt)
#
# (:etag => objetoactiverecord_que eu quero saber se mudou alguma coisa ou não)
#
# fresh_when (:etag => objetoactiverecord_que eu quero saber se mudou alguma coisa ou não)
