class ApplicationController < ActionController::API
  before_action :authenticate_user!
  attr_reader :current_user

  private

  def authenticate_user!
    auth_token = request.headers["Auth-Token"]
    @current_user = User.find_by(auth_token: auth_token) if auth_token

    unless @current_user
      render json: { error: 'Not Authorized' }, status: :unauthorized
    end
  end
end
