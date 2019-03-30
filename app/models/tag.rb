class Tag < ApplicationRecord
  #relations
  has_and_belongs_to_many :post

  #validation
  validates_presence_of :name, :slug
  validates :slug, uniqueness: { case_sensitive: false }
  validates :name, uniqueness: { case_sensitive: false }

  #callbacks
  before_validation do
    self.slug = self.name.parameterize
  end
end
