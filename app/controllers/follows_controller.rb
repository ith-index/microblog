class FollowsController < ApplicationController
  before_action :authorize_logged_in, only: [:create, :destroy]

  def create
    user = User.find(params[:followed_id])
    current_user.following << user
    html = render_to_string partial: 'unfollow', locals: {user: user}
    respond_to do |format|
      format.json { render json: {id: user.id, follower_count: view_context.pluralize(user.followers.count, 'Follower'), html: html} }
    end
  end

  def destroy
    user = Follow.find(params[:id]).followed
    current_user.following.delete(user)
    html = render_to_string partial: 'follow', locals: {user: user}
    respond_to do |format|
      format.json { render json: {id: user.id, follower_count: view_context.pluralize(user.followers.count, 'Follower'), html: html} }
    end
  end
end
