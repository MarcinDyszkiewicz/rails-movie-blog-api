class Movie < ApplicationRecord
  #relations
  has_many :posts

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



end
