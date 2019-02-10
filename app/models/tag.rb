class Tag < ApplicationRecord
  #relations
  has_and_belongs_to_many :post

  #validation
  validates_presence_of :name, :slug
end
