class PostsController < ApplicationController
  before_action :authorize_logged_in, only: [:create, :destroy]

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      html = render_to_string partial: 'post', locals: {post: @post}
      respond_to do |format|
        format.json { render json: {html: html} }
      end
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    respond_to do |format|
      format.json { render json: {id: post.id} }
    end
  end

  private
    def post_params
      params.require(:post).permit(:content)
    end
end
