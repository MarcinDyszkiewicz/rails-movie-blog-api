class Category < ApplicationRecord
  #relations
  has_and_belongs_to_many :posts

  # validation
  validates_presence_of :name, :slug
end
