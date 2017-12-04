class StocksController < ApplicationController
  def index
		@stocks = Stock.all
  end

	def import
		Stock.import(params[:file])
		redirect_to root_url, notice: "株価情報を追加しました"
	end

end
