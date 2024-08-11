class Api::V1::StocksController < ApplicationController
  def index
    stocks = Stock.all
    render json: {
      stocks: stocks.map do |stock|
        stock.attributes.merge(last_price: stock.last_price)
      end
    }
  end

  def show
    stock = Stock.find_by_symbol(CGI.unescape(params[:id]).upcase)
    render json: { stock: stock.attributes.merge(last_price: stock.last_price, last_5_prices: stock.stock_prices.last(5)) }
  end
end
