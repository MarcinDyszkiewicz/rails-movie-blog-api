class Actor < ApplicationRecord
  #relations
  has_and_belongs_to_many :movies, optional: true

  validates_presence_of :full_name, :slug
  validates :slug, uniqueness: { case_sensitive: false }
end
