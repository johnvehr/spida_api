module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      protect_from_forgery with: :exception
      include Api::Concerns::ActAsApiRequest

      private

      def sign_up_params
        params.require(:user).permit(
          :full_name, :email, :password, :password_confirmation, :origin, account_attributes: :subdomain )
      end

      def render_create_success
        #i need a better way to figure out if this is an account owner and they are responsible for paying
        if resource_data['origin'] == 'organic'
          User.find(resource_data['id']).account.create_stripe_customer(request.query_parameters)
          render json: { user: resource_data, account: User.find(resource_data['id']).account, organic: 'organic' }
        end
        if resource_data['origin'] == 'invite'
          invitation = Invitation.find_by(token: params[:token])
          accountId = invitation.account_id
          current_account ||= Account.find(accountId)
          new_user = User.find(resource_data['id'])
          invitation.update_attributes(pending: false)
          current_account.users << new_user
          render json: {user: resource_data, account: current_account,invite: 'invite'}
        end
      end
    end
  end
end
