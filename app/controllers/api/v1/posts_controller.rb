class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy ]
  before_action :authenticate_user!
  before_action :set_user

  # GET /posts
  def index
    # @posts = Post.all.order('created_at DESC')
    @posts = Post.all.with_attached_image.order('created_at DESC')
        render json: @posts.map { |p| 
            p.as_json(include: :user).merge({ image: url_for(p.image)})
        }

      # TODO: find a way to use jsonapi-serializer for Active Storage

    #   options ={}
    #   options[:include] = [:user, :'user.username']
    # render json: PostSerializer.new(@posts, options).serializable_hash.to_json, status: :ok
  end

  def get_current_user_posts
    @posts = Post.all.with_attached_image.where("user_id = ?", @user).order('created_at DESC')
    render json: @posts.map { |p| 
        p.as_json(include: :user).merge({ image: url_for(p.image)})
    }
  end
  

  # GET /posts/1
  def show
    options ={}
    options[:include] = [:user, :'user.username']
    render json: PostSerializer.new(@post, options).serializable_hash.to_json(include: :user), status: :ok
    # render json: @post.as_json(include: :user).merge({ image: url_for(@post.image)})
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

  def like
    @post = Post.find(params[:id])
    Like.create(user_id: current_user.id, post_id: @post.id)
    render json: @post.to_json(include: :likes), status: :ok
  end
  
  def un_like
    @post = Post.find(params[:id])
    @like = @post.likes.where(user_id: @user.id)
    if @like.present?
      @like.first.destroy
    end
    render json: @post.to_json(include: :likes), status: :ok
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
      params.permit(:caption, :user_id, :image)
    end
end
