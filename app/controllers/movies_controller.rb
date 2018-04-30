class MoviesController < ApplicationController
  def new
    @movie=Movie.new
  end
  def show
    @movie = Movie.find(params[:id])
  end
end
