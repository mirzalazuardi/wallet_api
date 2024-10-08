class Wallet < ActiveRecord::Base #ApplicationRecord
  belongs_to :ownable, polymorphic: true
  has_many :debits, foreign_key: 'source_wallet_id', class_name: 'Debit'
  has_many :credits, foreign_key: 'target_wallet_id', class_name: 'Credit'

  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  def deposit(amount)
    raise InvalidAmount if amount < 0
    self.balance += amount
    save!
  end

  def withdraw(amount)
    raise InvalidAmount if amount < 0
    raise NotEnoughFund if amount > balance

    self.balance -= amount
    save!
  end

  def self.query(type, key)
    raise TypeUnknown unless type.downcase.match?(/team|user|stock/)
    Stock.fetch_stock(key.upcase) if type.downcase == 'stock'
    field_hash = {team: :name, user: :email, stock: :identifier}
    args = {field_hash[type.downcase.to_sym] => key}
    resource_obj = type.capitalize.constantize.find_by(**args)
    find_or_create_by(ownable: resource_obj)
  end

  def ownable_response
    if ownable_type == 'Stock'
      ownable.slice(:identifier, :symbol, :last_price)
    elsif ownable_type == 'Team'
      ownable.slice(:name)
    else
      ownable.slice(:email)
    end
  end
end
