class Movie < ApplicationRecord
  #relations
  has_many :posts
  has_many :comments, as: :commentable
  has_and_belongs_to_many :actors
  has_and_belongs_to_many :directors
  has_and_belongs_to_many :genres

  accepts_nested_attributes_for  :actors, reject_if: :all_blank
  accepts_nested_attributes_for :directors, reject_if: :all_blank
  accepts_nested_attributes_for :genres, reject_if: :all_blank

  # validations
  validates_presence_of :title, :slug, :year
  validates :title, length: { minimum: 2, maximum: 255 },uniqueness: { scope: :year, message: "This movie already exists in database", case_sensitive: false }
  validates :slug, length: { minimum: 2, maximum: 255 }, uniqueness: { case_sensitive: false }
  validates :year, numericality: { only_integer: true }, length: { is: 4 }
  validates :released, allow_nil: true, :timeliness => { :type => :date}
  validates :runtime, allow_nil: true, numericality: { only_integer: true }
  validates :plot, length: { minimum: 10, maximum: 800 }
  validates :review, length: { minimum: 10, maximum: 500 }
  validates :poster, length: { minimum: 2, maximum: 500 }

  def self.new_with_relations(movie_params, actors, director, genres)
    movie = Movie.create!(movie_params)

    if actors
      actor_ids = []
      actors.each do |actor|
        actor = Actor.find_or_create_by!(full_name: actor[:full_name])
        actor_ids.push(actor.id)
      end
      movie.actor_ids = (actor_ids)
    end

    if director
      new_director = Director.find_or_create_by!(full_name: director[:full_name])
      movie.directors << new_director
    end

    if genres
      # genre_ids = []
      # genres.each { ||  }
      movie.genre_ids = (genres)
    end

    return movie
  end
end
