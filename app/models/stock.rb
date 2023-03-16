class Stock < ApplicationRecord
  has_one :wallet, as: :ownable
  has_many :stock_prices

  def last_price
    stock_prices.last.price
  end

  def self.fetch_stock(identifier = '')
    hash_data = parse_stock(latest_stock(identifier).first)
    quote = find_or_initialize_by(identifier: identifier)
    quote.update_attribute(:symbol, hash_data[:symbol])
    last_price = StockPrice
      .find_or_initialize_by(stock: quote, update_time: hash_data[:update_time])
    last_price.update_attribute(:price, hash_data[:price]) if last_price.new_record?
    quote
  end

  def self.latest_stock(identifier)
    obj = JSON.parse(LatestStockPrice.new('any', "Identifier=#{identifier}").exec)
    raise StockNotFound if obj.blank?
    obj
  end

  def self.parse_stock(hash_data)
    {}.tap do |h|
      h[:identifier] = hash_data['identifier']
      h[:symbol] = hash_data['symbol']
      h[:price] = hash_data['lastPrice']
      h[:update_time] = DateTime.strptime(hash_data['lastUpdateTime'], '%d-%b-%Y %H:%M:%S')
    end
  end

end
