class Users::RegistrationsController < Devise::RegistrationsController
    respond_to :json
    skip_before_action :require_no_authentication
  
    private
  
    def respond_with(resource, _opts = {})
      register_success && return if resource.persisted?
  
      register_failed
    end
  
    def register_success
      @token = current_token
      render json: {
        message: 'Signed up sucessfully.',
        user: current_user,
        jwt: @token
      }, status: :ok
    end
  
    def register_failed
      render json: { message: 'Something went wrong.' }, status: :unprocessable_entity
    end
    def current_token
      request.env['warden-jwt_auth.token']
    end
  end