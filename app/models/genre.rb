class Genre < ApplicationRecord
  #relations
  has_and_belongs_to_many :movies

  # validation
  validates_presence_of :name, :slug
end
