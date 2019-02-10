class Actor < ApplicationRecord
  #relations
  has_and_belongs_to_many :movies, optional: true
end
