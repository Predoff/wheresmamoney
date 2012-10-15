class ExtractsController < ApplicationController
  respond_to :js
  helper_method :date_to_show
	
  def by_month

    transactions = current_user.transactions.by_month(date_to_show).order("date DESC")
    @incomes = transactions.income.group_by(&:date)
    @outgoes = transactions.outgo.group_by(&:date)
    @transactions = transactions.group_by(&:date)

    total = 0
    current_user.incomes.where(date: date_to_show.beginning_of_month..date_to_show.end_of_month).each do |i|
      total += i.value
    end
    @total_income = total

    total = 0
    current_user.outgoes.where(date: date_to_show.beginning_of_month..date_to_show.end_of_month).each do |o|
      total += o.value
    end
    @total_outgo = total

    @total_balance = @total_income - @total_outgo
  end

  def by_year

    transactions = current_user.transactions.by_year(date_to_show).order("date DESC")
    incomes = transactions.income.group_by{ |income| income.date.month }
    outgoes = transactions.outgo.group_by{ |outgo| outgo.date.month }

    #porquisses master daqui pra baixo que depois eu arrumo
    @lines_to_print = {}
    date = Date.current

    incomes.each do |incomes_by_month|
      transactions_in_this_month = incomes_by_month.last
      date = transactions_in_this_month.first.date.beginning_of_month
      total = 0

      transactions_in_this_month.each do |transaction|
        total += transaction.value
      end
      @lines_to_print[date] = []
      @lines_to_print[date][0] = total
    end

    outgoes.each do |outgoes_by_month|
      transactions_in_this_month = outgoes_by_month.last
      date = transactions_in_this_month.first.date.beginning_of_month
      total = 0

      transactions_in_this_month.each do |transaction|
        total += transaction.value
      end
      @lines_to_print[date][1] = total
    end

    @total_income = 0
    @total_outgo = 0

    @lines_to_print.each do |line_to_print|
      line_to_print.last[2] = line_to_print.last[0] - line_to_print.last[1]

      @total_income += line_to_print.last[0]
      @total_outgo += line_to_print.last[1]
    end

    @total_balance = @total_income - @total_outgo
    #fim da porquisses master que dpeois eu arrumo

  end

  def custom
  end

  def index
    @user_name = current_user.name
    @categories = current_user.categories.order('name')
    @sources = current_user.sources.order('name')
    @tags = current_user.tags.order(:name).map{ |tag| tag.name }
  end

  def recent
    transactions = current_user.transactions.order("date DESC")
    @incomes = transactions.income.limit(12).group_by(&:date)
    @outgoes = transactions.outgo.limit(12).group_by(&:date)
    @transactions = transactions.limit(12).group_by(&:date)
  end

  def date_to_show
    @date_to_show ||= if params[:date_action] == "previous"
      params[:date].to_date - (action_name == "by_month" ? 1.month : 1.year)
    elsif params[:date_action] == "next"
      params[:date].to_date + (action_name == "by_month" ? 1.month : 1.year)
    elsif params[:date]
      params[:date].to_date
    else
      Date.current
    end
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