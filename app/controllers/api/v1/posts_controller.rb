class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy ]
  before_action :set_user
  before_action :authenticate_user!

  # GET /posts
  def index
    @posts = Post.all.order('created_at DESC')

    render json: PostSerializer.new(@posts).serializable_hash.to_json, status: :ok
  end

  # GET /posts/1
  def show
    render json: PostSerializer.new(@post).serializable_hash.to_json, status: :ok
  end

  # POST /posts
  def create
    @post = @user.posts.build(post_params)

    if @post.save
      render json: PostSerializer.new(@post).serializable_hash.to_json, status: :created, location: @api_v1_post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: PostSerializer.new(@post).serializable_hash.to_json
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def set_user
      @user = current_user
    end
    

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:caption, :user_id, :image)
    end
end
