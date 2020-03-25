module Api
  module V1
    class SessionsController < DeviseTokenAuth::SessionsController
      protect_from_forgery with: :null_session
      include Api::Concerns::ActAsApiRequest

      private

      def resource_params
        params.require(:user).permit(:email, :password)
      end

      def render_create_success
        user = User.find(resource_data['id'])

        ActionCable.server.broadcast 'online_channel',
        content: 'online',
        user: user

        render json: {
          user: resource_data,
          account: user.account,
          accounts: user.accounts
        }

      end
    end
  end
end
