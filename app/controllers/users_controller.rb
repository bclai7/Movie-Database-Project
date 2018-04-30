class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :show, :index]
  before_action :correct_user,   only: [:edit, :update, :show]
  before_action :non_user, only: [:new, :create] # only non logged in users can access registration page
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
      log_in @user # automatically log user in after registering
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

    # Check if logged in
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Check if user object matches logged in user
    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        flash[:danger] = "Cannot view that page"
        redirect_to(root_url)
      end
    end

    def non_user
      unless !logged_in?
        flash[:danger] = 'You are already registered'
        redirect_to current_user
      end
    end

end
