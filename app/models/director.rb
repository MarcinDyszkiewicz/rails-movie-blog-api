class Director < ApplicationRecord
  #relations
  has_and_belongs_to_many :movies, optional: true

  #validations
  validates_presence_of :full_name, :slug
  validates :slug, uniquess: true
end
