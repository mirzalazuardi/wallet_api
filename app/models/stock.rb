class Stock < ApplicationRecord
  has_one :wallet, as: :ownable
  has_many :stock_prices
end
