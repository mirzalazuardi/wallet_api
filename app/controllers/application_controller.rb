class ApplicationController < ActionController::API
  attr_reader :current_user
  rescue_from NotEnoughFund, with: :not_enough_fund
  rescue_from InvalidAmount, with: :invalid_amount
  rescue_from WalletNotFound, with: :wallet_not_found
  rescue_from StockNotFound, with: :stock_not_found

  def not_enough_fund
    render json: {error: 'not enough fund'}
  end

  def stock_not_found
    render json: {error: 'stock not found'}
  end

  def wallet_not_found
    render json: {error: 'wallet not found'}
  end

  def invalid_amount
    render json: {error: 'invalid amount'}
  end

  def authenticate
    session_obj = Session.find_by(token: (request.headers['token']))
    return render json: { data: 'invalid auth'}, status: :unauthorized if session_obj.blank?
    @current_user = User.find(session_obj.user_id)
  end
end
