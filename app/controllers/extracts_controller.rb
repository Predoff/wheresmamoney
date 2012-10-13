class ExtractsController < ApplicationController
  respond_to :js
	
  def by_month
    if params[:date_action] == "previous"
      date = params[:date].to_date - 1.month
    elsif params[:date_action] == "next"
      date = params[:date].to_date + 1.month
    end

    @date_to_show = date || Date.current

    @incomes = current_user.incomes.where(date: @date_to_show.beginning_of_month..@date_to_show.end_of_month).order("date DESC").group_by(&:date)
    @outgoes = current_user.outgoes.where(date: @date_to_show.beginning_of_month..@date_to_show.end_of_month).order("date DESC").group_by(&:date)
    @transactions = Transaction.where(user_id: current_user.id).where(date: @date_to_show.beginning_of_month..@date_to_show.end_of_month).order("date DESC").group_by(&:date)

    total = 0
    current_user.incomes.where(date: @date_to_show.beginning_of_month..@date_to_show.end_of_month).each do |i|
      total += i.value
    end
    @total_income = total

    total = 0
    current_user.outgoes.where(date: @date_to_show.beginning_of_month..@date_to_show.end_of_month).each do |o|
      total += o.value
    end
    @total_outgo = total

    @total_balance = @total_income - @total_outgo
  end

  def by_year
  end

  def custom
  end

  def index
    @user_name = current_user.name
    @categories = current_user.categories.order('name')
    @sources = current_user.sources.order('name')
    @tags = current_user.tags.order(:name).map { |tag| tag.name }
  end

  def recent
    @incomes = current_user.incomes.order("date DESC").limit(12).group_by(&:date)
    @outgoes = current_user.outgoes.order("date DESC").limit(12).group_by(&:date)
    @transactions = Transaction.where(user_id: current_user.id).order("date DESC").limit(12).group_by(&:date)
  end
end
