module Api
  module V1
    class ApiController < ApplicationController
      include Api::Concerns::ActAsApiRequest
      include DeviseTokenAuth::Concerns::SetUserByToken

      before_action :authenticate_user!, except: :status
      before_action :current_account, except: :status
      before_action :owner?, except: :status

      before_action :configure_permitted_parameters, if: :devise_controller?

      def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up) { |u|
          u.permit(:full_name, :email, :password, :password_confirmation,:origin, account_attributes: :subdomain)
        }
      end

      layout false
      respond_to :json

      rescue_from Exception,                           with: :render_error
      rescue_from ActiveRecord::RecordNotFound,        with: :render_not_found
      rescue_from ActiveRecord::RecordInvalid,         with: :render_record_invalid
      rescue_from ActionController::RoutingError,      with: :render_not_found
      rescue_from AbstractController::ActionNotFound,  with: :render_not_found
      rescue_from ActionController::ParameterMissing,  with: :render_parameter_missing

      def require_account!
        #redirect_to root_url() if @account.nil?
      end

      def status
        render json: { online: true }
      end

      private

      def render_error(exception)
        raise exception if Rails.env.test?

        # To properly handle RecordNotFound errors in views
        return render_not_found(exception) if exception.cause.is_a?(ActiveRecord::RecordNotFound)

        logger.error(exception) # Report to your error managment tool here

        return if performed?

        render json: { error: I18n.t('api.errors.server') }, status: :internal_server_error
      end

      def render_not_found(exception)
        logger.info(exception) # for logging
        render json: { error: I18n.t('api.errors.not_found') }, status: :not_found
      end

      def render_record_invalid(exception)
        logger.info(exception) # for logging
        render json: { errors: exception.record.errors.as_json }, status: :bad_request
      end

      def render_parameter_missing(exception)
        logger.info(exception) # for logging
        render json: { error: I18n.t('api.errors.missing_param') }, status: :unprocessable_entity
      end

      def current_account
        @current_account ||= Account.find_by!(subdomain: params[:subdomain])
        #render json: @current_account
      end
      helper_method :current_account

      def owner?
        current_account.user_id == current_user.id
      end
      helper_method :owner?

      def set_account
        @account = Account.find_by(subdomain: request.subdomain)
      end
    end
  end
end
