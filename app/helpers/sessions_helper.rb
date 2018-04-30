module SessionsHelper
  # Log in user by storing their id in session variable
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_user?(user)
    user == current_user
  end
  
  # Checks if user is currently logged in to session
  def logged_in?
    !current_user.nil?
  end

  # log current user out by deleting session cookie
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
