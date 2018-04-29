class UsersController < ApplicationController
  def new
    # create new User object for registration page
    @user=User.new
  end

  # Show user's personal page, has the link "users/[id]"
  def show
    # Find user by id
    @user = User.find(params[:id])
  end

  # Create user object and store in DB
  def create
    @user = User.new(user_params) # Creates user object from form fields
    if @user.save # Tries to save to database
      # If successful, print success message and redirect to profile page
      flash[:success] = "Thank you for registering!"
      redirect_to @user
    else
      # Else reload registration form (possibly with error messages)
      render 'new'
    end
  end


  private
    def user_params
      # Only permit necessary fields when user enters information
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

end
