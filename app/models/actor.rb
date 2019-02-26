class Actor < ApplicationRecord
  #relations
  has_and_belongs_to_many :movies, optional: true

  #validations
  validates_presence_of :full_name
  validates :slug, uniqueness: { case_sensitive: false }

  #callbacks
  before_create do
    self.slug = self.full_name.parameterize
  end
end
