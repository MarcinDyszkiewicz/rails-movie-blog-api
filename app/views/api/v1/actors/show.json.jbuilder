json.data do
  json.id @actor.id
  json.full_name @actor.full_name
  json.movies @actor.movies
end

json.message "Loaded actor"
json.success true