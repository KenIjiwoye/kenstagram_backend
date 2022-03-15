class Users::SessionsController < Devise::SessionsController
    respond_to :json
    skip_before_action :require_no_authentication
    
  
    private
  
    def respond_with(_resource, _opts = {})
    @token = current_token
      render json: {
        message: 'You are logged in.',
        user: current_user,
        jwt: @token
      }, status: :ok
    end
  
    def respond_to_on_destroy
      current_user ? log_out_success : log_out_failure
  
    end
  
    def log_out_success
      render json: { message: 'You are logged out.' }, status: :ok
    end
  
    def log_out_failure
      render json: { message: 'Hmm nothing happened.' }, status: :unauthorized
    end
    def current_token
      request.env['warden-jwt_auth.token']
    end
  end