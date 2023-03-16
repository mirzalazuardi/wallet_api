class Dealing < ApplicationRecord
  belongs_to :wallet
  belongs_to :source_wallet, class_name: 'Wallet', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', optional: true

  validates :amount, numericality: { greater_than: 0 }
  validate :check_wallet_presence

  after_create :assign_type
  after_create :update_balance

  def assign_type
    self.type = source_wallet.present? ? 'Debit' : 'Credit'
  end

  def update_balance
    ActiveRecord::Base.transaction do
      if type == 'Debit'
        source_wallet.withdraw(amount)
        wallet.deposit(amount)
        self.class.insert({type: 'Credit', target_wallet_id: wallet.id,
                           wallet_id: source_wallet_id, amount: amount})
      else
        target_wallet.deposit(amount)
        wallet.withdraw(amount)
        self.class.insert({type: 'Debit', source_wallet_id: wallet.id,
                           wallet_id: target_wallet_id, amount: amount})
      end
    end
  end

  private

  def check_wallet_presence
    errors.add(:base, 'Fill source or target wallet') if source_wallet.blank? && target_wallet.present?
    errors.add(:base, 'Cannot add source and target wallet in the same time') if source_wallet.blank? && target_wallet.present?
  end
end
