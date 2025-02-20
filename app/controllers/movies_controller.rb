class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def new_movie
    @title = params["title"]
    @year = params["year"]
    @description = params["description"]
    @director_id = params["director_id"]
    @image = params["image"]

    new_movie = Movie.new
    new_movie.title = @title
    new_movie.year = @year
    new_movie.description = @description
    new_movie.director_id = @director_id
    new_movie.image = @image
    new_movie.save
    redirect_to("/movies")

  end
end
