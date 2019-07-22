# frozen_string_literal: true

# ApplicationController has custom methods providing Auth handling for the JSON API.
class ApplicationController < ActionController::API
  attr_reader :current_user

  rescue_from AuthenticationError do |_exception|
    render({ json: { error: 'Not Authorized' }, status: :unauthorized })
  end

  before_action :authenticate_user!

  private

  def authenticate_user!
    auth_token = request.headers['Auth-Token']
    raise AuthenticationError unless auth_token.present?

    @current_user = User.find_by(auth_token: auth_token)
    raise AuthenticationError unless @current_user
  end
end
