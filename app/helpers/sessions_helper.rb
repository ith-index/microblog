module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def logged_in?
    !session[:user_id].nil?
  end 
  def authorize_not_logged_in
    if logged_in?
      redirect_to dashboard_url
    end
  end

  def authorize_logged_in
    unless logged_in?
      flash[:failure] = 'Please log in first.'
      redirect_to log_in_url
    end
  end

  def current_user
    if logged_in?
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def current_user?(user)
    current_user == user
  end
end
