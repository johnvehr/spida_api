module Api
  module V1
    class UsersController < Api::V1::ApiController
      def show
      end

      def profile
        @current_user = current_user
        if @current_user.account_owner?(current_account)
          render json: {
            user: @current_user,
            account: current_account,
            account_users: current_account.users,
            account_owner: true,
            account_subscription: current_account.subscription
          }
        else
          render json: {
            user: @current_user,
            account: current_account,
            account_users: current_account.users,
            account_owner: false
          }
        end
      end

      def update
        current_user.update!(user_params)
        render :show
      end

      private

      def user_params
        params.require(:user).permit(
          :full_name,
          :email,
          :origin,
          account_attributes: :subdomain
        )
      end
    end
  end
end
