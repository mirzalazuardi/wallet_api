module Transactable
  extend ActiveSupport::Concern

  def deposit
    raise InvalidAmount if params[:amount].to_f < 0

    wallet = Wallet.query(params[:entity_type], params[:entity_query])
    obj = Credit.create(wallet: current_user.wallet, target_wallet: wallet,
                  amount: params[:amount])

    render json: { balance: current_user.wallet.balance, target: wallet.ownable.to_json(only: [:email, :name, :identifier]),
                   status: 'deposit to target successfully' }
  end

  def withdraw
    raise InvalidAmount if params[:amount].to_f < 0

    wallet = Wallet.query(params[:entity_type], params[:entity_query])
    obj = Debit.create(wallet: current_user.wallet, source_wallet: wallet,
                  amount: params[:amount])

    render json: { balance: current_user.wallet.balance, source: wallet.ownable.to_json(only: [:email, :name, :identifier]),
                   status: 'withdraw to from successfully' }
  end
end
