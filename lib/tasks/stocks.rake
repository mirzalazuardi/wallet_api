namespace :stocks do
  desc "Update stocks using LatestStockPrice and record to Stock and StockPrice models"
  task update: :environment do
    latest_prices = LatestStockPrice.new('any').exec
    latest_prices = JSON.parse(latest_prices)

    latest_prices.each do |stock_data|
      stock = Stock.find_or_create_by(identifier: stock_data['identifier'], symbol: stock_data['symbol'])

      update_time = DateTime.strptime(stock_data['lastUpdateTime'], '%d-%b-%Y %H:%M:%S')
      StockPrice.find_or_initialize_by(stock: stock, update_time: update_time).
      update_attribute(:price, stock_data['lastPrice'])
    end

    puts "Stocks and stock prices have been updated."
  end
end
