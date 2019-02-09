class Post < ApplicationRecord
  #relations
  belongs_to :user
  belongs_to :movie

end
