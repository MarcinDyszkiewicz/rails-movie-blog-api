json.data do
  json.array! @movies do |movie|
    json.id movie.id
    json.slug movie.slug
    json.title movie.title
    json.year movie.year
    json.released movie.released
    json.runtime movie.runtime
    json.plot movie.plot
    json.review movie.review
    json.poster movie.poster
    json.rotten_tomatoes_rating movie.rotten_tomatoes_rating
    json.metacritic_rating movie.metacritic_rating
    json.imdb_raiting movie.imdb_raiting
    json.created_at movie.created_at.to_date
    json.updated_at movie.updated_at.to_date
    json.actors movie.actors do |actor|
      json.id actor.id
      json.full_name actor.full_name
      json.slug actor.slug
    end
    json.directors movie.directors do |director|
      json.id director.id
      json.full_name director.full_name
      json.slug director.slug
    end
    json.genres movie.genres do |genre|
      json.id genre.id
      json.full_name genre.name
      json.slug genre.slug
    end
  end
end

json.message "Loaded all movies"
json.success true