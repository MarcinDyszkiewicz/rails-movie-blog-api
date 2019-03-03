class CreateMovie
  def initialize(movie_params, actors, director, genre)
    @movie_params = movie_params
    @actors = actors
    @director = director
    @genre = genre
  end

  def create
    @movie = Movie.create!(movie_params)

    if @actors
      attach_actors
    end

    if @director
      attach_director
    end

    if @genre
      attach_genres
    end

    @movie
  end

  private

  def attach_actors
    actor_ids = []
    @actors.each do |actor|
      actor = Actor.find_or_create_by!(full_name: actor[:full_name])
      actor_ids.push(actor.id)
    end
    @movie.actor_ids = (actor_ids)
  end

  def attach_director
    new_director = Director.find_or_create_by!(full_name: director[:full_name])
    @movie.directors << new_director
  end

  def attach_genres
    @movie.genre_ids = (@genre)
  end
end