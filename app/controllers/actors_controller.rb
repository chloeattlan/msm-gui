class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def insert_actor
    actor = Actor.new
    actor.name = params['name']
    actor.dob = params['dob']
    actor.bio = params['bio']
    actor.image = params['image']
    actor.save

    redirect_to("/actors")
  end

  def delete_actor
    the_id = params['actor_id']
    act = Actor.where({ :id => the_id})[0]
    act.destroy
    redirect_to("/actors")
  end

  def modify_actor
    the_id = params['actor_id']
    actor = Actor.where({ :id => the_id})[0]
    
    actor.name = params['name']
    actor.dob = params['dob']
    actor.bio = params['bio']
    actor.image = params['image']
    actor.save

    redirect_to("/actors/#{actor.id}")
  end
end
