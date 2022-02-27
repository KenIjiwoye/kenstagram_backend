class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]
  before_action :authenticate_user!

  def index
    @users = User.all
    render json: UserSerializer.new(@users).serializable_hash.to_json, status: :ok
  end

  def show
    options = {}
    options[:include] = [:posts, :'posts.caption', :'posts.image']
    render json: UserSerializer.new(@user, options).serializable_hash.to_json
  end
  
  

 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_user
      @user = current_user
    end
    

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:user).permit(:username, :email)
    end
end
