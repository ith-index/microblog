class UsersController < ApplicationController
  before_action :authorize_not_logged_in, only: [:new, :create]
  before_action :authorize_logged_in, only: [:index, :show]

  def index
    @users = User.where.not(id: current_user.id).order(:username)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'Welcome!'
      redirect_to dashboard_url
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @post = current_user.posts.build
    @posts = @user.posts.order(created_at: :desc)
  end

  private
    def user_params
      params
        .require(:user)
        .permit(:username, :email, :password, :password_confirmation)
    end
end
