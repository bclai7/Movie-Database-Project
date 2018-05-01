class MoviesController < ApplicationController
  before_action :valid_user, only: [:edit, :new, :update, :destroy]

  def index
    @movie_list=Movie.all

    @movie_list.each do |m|
      @ratings = Rating.where(movie_id: m.id)
      if @ratings.average(:rating_value) and m.avg_rating==0.0
        m.avg_rating=@ratings.average(:rating_value).round(1)
        m.save
      end
    end

    if params[:search]
      @movie_list = Movie.where('title ILIKE ?', "%#{params[:search]}%")
    else
      @movie_list = Movie.all
    end
  end

  def new
    @movie=Movie.new
  end

  def show
    # Find movie to display by id
    @movie = Movie.find(params[:id])
    session[:current_movie_id]=@movie.id

    # Get all ratings for the movie by querying for movie_id in the rating table
    @ratings = Rating.where(movie_id: params[:id])

    # Check if user is logged in, if so, show their rating to edit
    if logged_in?
      @my_rating = Rating.find_by(movie_id: params[:id], user_id: current_user.id)
    end

    # Get movie's average rating to show on page
    if @ratings.average(:rating_value)
      @movie.avg_rating=@ratings.average(:rating_value).round(1)
      @movie.save
    end

    # If user hasn't rated movie yet, create new rating object for user to rate
    if @my_rating == nil
      @my_rating=Rating.new
    end
  end

  def add_rating
    @rating = Rating.new(rating_params)
    @movie = Movie.find(session[:current_movie_id])
    @user_id = current_user.id

    @rating.movie_id=@movie.id
    @rating.user_id = @user_id

    if @rating.save
      flash[:success] = "Rating Saved"
      redirect_to @movie
    else
      flash[:danger] = "Unable to save rating"
      redirect_to @movie
    end
  end

  def update_rating
    @movie = Movie.find(session[:current_movie_id])
    @user_id = current_user.id
    @my_rating = Rating.find_by(movie_id: @movie.id, user_id: @user_id)
    @my_rating.update(rating_params)

    @my_rating.movie_id=@movie.id
    @my_rating.user_id = @user_id

    if @my_rating.save
      flash[:success] = "Rating Saved"
      redirect_to @movie
    else
      flash[:danger] = "Unable to save rating"
      redirect_to @movie
    end
  end


  # Create movie object and store in DB
  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      flash[:success] = "Movie added!"
      redirect_to @movie
    else
      render 'new'
    end
  end

  private
    def movie_params
      # Only permit necessary fields when user enters information
      params.require(:movie).permit(:title, :plot, :release_date, :poster)
    end

    def rating_params
      # Only permit rating and comment
      params.require(:rating).permit(:rating_value, :comment, :movie_id, :user_id)
    end

    def valid_user
      unless logged_in? and is_admin?
        flash[:danger] = "You cannot access that page."
        redirect_to root_url
      end
    end
end
