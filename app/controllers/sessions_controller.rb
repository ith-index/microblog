class SessionsController < ApplicationController
  before_action :authorize_not_logged_in, only: [:new, :create]
  before_action :authorize_logged_in, only: [:destroy]

  def new
  end

  def create
    emailOrUsername = params[:session][:email_or_username].downcase
    user = User.find_by(email: emailOrUsername) || User.find_by(username: emailOrUsername)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to dashboard_url
    else
      flash.now[:failure] = 'Invalid email/password combination.'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
