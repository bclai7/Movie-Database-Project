class SessionsController < ApplicationController
  before_action :non_user, only: [:new, :create] # only non logged in users can access login page

  def new
  end

  # Create user session AKA logging in
  def create
    # Create user object
    user = User.find_by(email: params[:session][:email].downcase)
    # Try to authenticate input password with stored password
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      flash[:success] = 'Logged In Successfully'
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:success] = 'Logged Out Successfully'
    redirect_to root_url
  end

  private
    def non_user
      unless !logged_in?
        flash[:danger] = 'You are already logged in'
        redirect_to current_user
      end
    end
end
