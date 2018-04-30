class SessionsController < ApplicationController
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
end
