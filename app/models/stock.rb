class Stock < ApplicationRecord
  has_one :wallet, as: :ownable
  has_many :stock_prices

  def self.latest_stock(identifier)
    JSON.parse(LatestStockPrice.new('any', "Identifier=#{identifier}").exec)
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
