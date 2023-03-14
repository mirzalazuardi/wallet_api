class Api::V1::SessionController < ApplicationController

  def create
    user = User.find_by_email params[:email]
    auth = user&.authenticate(params[:password])

    if auth
      session = user.sessions.create!
      render json: { token: session.token }
    else
      render json: { error: 'Invalid session' }, status: :unauthorized
    end
  end
end
