class Wallet < ActiveRecord::Base #ApplicationRecord
  belongs_to :ownable, polymorphic: true
  has_many :debits, foreign_key: 'source_wallet_id', class_name: 'Debit'
  has_many :credits, foreign_key: 'target_wallet_id', class_name: 'Credit'

  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  def deposit(amount)
    raise 'Invalid amount' if amount < 0
    self.balance += amount
    save!
  end

  def withdraw(amount)
    raise 'Invalid amount' if amount < 0
    raise 'Not enough fund' if amount > balance

    self.balance -= amount
    save!
  end
end
