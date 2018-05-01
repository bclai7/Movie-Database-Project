class RatingsController < ApplicationController
  def new
  end

  def create
    @rating = Rating.new(rating_params)
    if @rating.save
      flash[:success] = "Rating Saved"
      redirect_to 'movies/'+@rating.movie_id
    else
      render 'movies/'+@rating.movie_id
    end
  end

  private
    def rating_params
      # Only permit rating and comment
      params.require(:rating).permit(:rating_value, :comment, :movie_id, :user_id)
    end
end
