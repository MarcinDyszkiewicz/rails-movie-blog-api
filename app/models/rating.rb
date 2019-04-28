class Rating < ApplicationRecord
  # relations
  belongs_to :ratingable, polymorphic: true
  belongs_to :user

  # validations
  validates_presence_of :user, :rate
  validates :rate, numericality: { only_integer: true }, :inclusion => 1..10, uniqueness: { scope: [:user, :ratingable_id, :ratingable_type],
                                                                                            :message => Proc.new { |rating| "You already rated this #{rating.ratingable_type}"}}
end
