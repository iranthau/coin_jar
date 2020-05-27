module Api
  class RegistrationController < Api::ApiController
    skip_before_action :authorize_user

    def create
      user = User.new(user_params)

      return render json: { token: token }, status: :created if user.save

      render json: { error: user.errors.messages }, status: :bad_request
    end

    private

    def token
      payload = {
        id: User.find_by(username: user_params[:username]).id
      }

      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def user_params
      params.require(:user).permit(:username, :password)
    end
  end
end