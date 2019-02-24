class Genre < ApplicationRecord
  #relations
  has_and_belongs_to_many :movies

  #callbacks
  before_validation :create_slug_from_name

  # validation
  validates_presence_of :name, :slug
  validates :name, length: { minimum: 2, maximum: 255 }, uniqueness: { case_sensitive: false }
  validates :slug, length: { minimum: 2, maximum: 255 }, uniqueness: { case_sensitive: false }

  private
    def create_slug_from_name
      self.slug = name.parameterize
    end
end
