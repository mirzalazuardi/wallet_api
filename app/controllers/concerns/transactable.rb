module Transactable
  extend ActiveSupport::Concern

  def deposit
    raise InvalidAmount if params[:amount].to_f < 0

    obj = Credit.create(wallet: current_user.wallet, target_wallet: wallet,
                  amount: params[:amount])
    stock_operation if params[:entity_type].downcase == 'stock' && wallet.present?
    raise WalletNotFound if wallet.blank?

    render json: { balance: current_user.wallet.balance,
                   target: wallet.ownable.to_json(only: [:email, :name, :identifier]),
                   status: 'deposit to target successfully' }
  end

  def withdraw
    raise InvalidAmount if params[:amount].to_f < 0

    obj = Debit.create(wallet: current_user.wallet, source_wallet: wallet,
                  amount: params[:amount])
    stock_operation if params[:entity_type].downcase == 'stock' && wallet.present?

    render json: { balance: current_user.wallet.balance, source: wallet.ownable.to_json(only: [:email, :name, :identifier]),
                   status: 'withdraw from source successfully' }
  end

  private

  def wallet
    Wallet.query(params[:entity_type], params[:entity_query])
  end

  def stock_operation
    qty_stock = (params[:amount].to_f / wallet.ownable.last_price ).to_i

    raise NotEnoughFund if params[:amount].to_f < wallet.ownable.last_price
    params[:amount] = wallet.ownable.last_price * qty_stock
  end
end
