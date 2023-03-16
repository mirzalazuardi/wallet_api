class ApplicationController < ActionController::API
  attr_reader :current_user

  def authenticate
    session_obj = Session.find_by(token: (request.headers['token']))
    return render json: { data: 'invalid auth'}, status: :unauthorized if session_obj.blank?
    @current_user = User.find(session_obj.user_id)
  end
end
