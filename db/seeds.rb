# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
imdb_genre_list = [
    %w(Action action),
    %w(Adventure adventure),
    %w(Animation animation),
    %w(Biography biography),
    %w(Comedy comedy),
    %w(Crime crime),
    %w(Documentary documentary),
    %w(Drama drama),
    %w(Family family),
    %w(Fantasy fantasy),
    %w(Film Noir film-noir),
    %w(History history),
    %w(Horror horror),
    %w(Music music),
    %w(Musical musical),
    %w(Mystery mystery),
    %w(Romance romance),
    %w(Sci-Fi sci-fi),
    %w(Short short),
    %w(Sport sport),
    %w(Superhero superhero),
    %w(Thriller thriller),
    %w(Western western),
    %w(War war),
]
imdb_genre_list.each do |name, slug|
  Genre.create(name: name, slug: slug)
end

category_list = [
    %w(hot hot),
    %w(popular popular),
]

category_list.each do |name, slug|
  Category.create(name: name, slug: slug)
end