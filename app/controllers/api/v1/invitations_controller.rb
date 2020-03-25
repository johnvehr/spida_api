module Api
  module V1
    class InvitationsController < Api::V1::ApiController
      skip_before_action :authenticate_user!, only: [:accepted]
      before_action :authorize_owner!, except: [:accepted]
      before_action :account_status
      #before_action :check_guest_limit

      def create
        #maybe here I should pass in my current account stuff
        if !current_account.guest_limit
          params['invite_emails'].each do |ie|
            puts ie
            @email = ie['email']
            invite = current_account.invitations.create(email: @email, pending: ie['pending'])
            InvitationMailer.invite(invite,account_status).deliver_later
          end
          pending = current_account.invitations.where(pending: true)
          render json: {
              invitations_sent: current_account.invitations,
              invitation_sent: @invitation,
              pending_invites: pending
            }
        else
          render json: {
            error: 'Looks like you reached your max limit'
          }
        end
      end

      private

      #def check_guest_limit
      #  current_account.guest_limit
      #end

      def invite_account_status
        User.find_by(email: @email)
      end

      def account_status
        invite_account_status ||= 'invite'
      end

      def invitation_params
        params.permit(:email,:account_id,:status,:pending) #add default to status
      end

      def authorize_owner!
        current_user.id == current_account.user_id
      end

    end
  end
end
