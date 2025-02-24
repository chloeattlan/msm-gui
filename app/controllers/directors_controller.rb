class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def insert_director
    director = Director.new
    director.name = params['name']
    director.dob = params['dob']
    director.bio = params['bio']
    director.image = params['image']

    director.save

    redirect_to("/directors")
  end

  def delete_director
    the_id = params['director_id']
    director = Director.where({ :id => the_id})[0]
    director.destroy
    redirect_to("/directors")
  end

  def modify_director
    the_id = params['director_id']
    director = Director.where({ :id => the_id})[0]

    director.name = params['name']
    director.dob = params['dob']
    director.bio = params['bio']
    director.image = params['image']

    director.save

    redirect_to("/directors/#{director.id}")
  end
end
