class MoviesController < ApplicationController
  before_action :valid_user, only: [:edit, :new, :update, :destroy]

  def new
    @movie=Movie.new
  end

  def show
    @movie = Movie.find(params[:id])
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

    def valid_user
      unless logged_in? and is_admin?
        flash[:danger] = "You cannot access that page."
        redirect_to root_url
      end
    end
end
