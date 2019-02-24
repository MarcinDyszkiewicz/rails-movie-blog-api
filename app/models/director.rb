class Director < ApplicationRecord
  #relations
  has_and_belongs_to_many :movies, optional: true

  #validations
  validates_presence_of :full_name, :slug
  validates :slug, uniqueness: { case_sensitive: false }

  #callbacks
  before_validation :create_slug_from_full_name

  private
  def create_slug_from_full_name
    self.slug = full_name.parameterize
  end
end
