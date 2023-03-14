class Stock < ApplicationRecord
  has_one :wallet, as: :ownable
end
