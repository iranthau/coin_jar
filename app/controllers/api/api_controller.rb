module Api
  class ApiController < ActionController::API
    before_action :authorize_user

    def authorize_user
      token = request.headers['Authorization'].split.last
      id = JWT.decode(token, Rails.application.secrets.secret_key_base).first.with_indifferent_access[:id]

      @current_user = User.find(id)
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
      render json: { errors: 'Not Authorised' }, status: :unauthorized
    end
  end
end