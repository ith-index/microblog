class PagesController < ApplicationController
  before_action :authorize_not_logged_in, only: [:home]
  before_action :authorize_logged_in, only: [:dashboard]
  
  def home
    @user = User.new
  end

  def dashboard
    @post = current_user.posts.build
    following_ids = "SELECT followed_id FROM follows WHERE follower_id = :user_id"
    @posts = Post.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: current_user.id).order(created_at: :desc)
  end

  def FourZeroFour
  end
end
