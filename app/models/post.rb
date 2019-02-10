class Post < ApplicationRecord
  #relations
  belongs_to :user, optional: true
  belongs_to :movie, optional: true
  has_many :comments, as: :commentable
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :tags

  accepts_nested_attributes_for :tags

  #validation
  validates_presence_of :title, :slug, :body, :image
  validates :user_id, numericality: { only_integer: true }, allow_nil: true
  validates :movie_id, numericality: { only_integer: true }, allow_nil: true
  validates :slug, length: { minimum: 2, maximum: 255 }, uniqueness: { case_sensitive: false }
  validates :title, length: { minimum: 2, maximum: 255 }, uniqueness: { scope: :is_published, message: "Post with this title already exists", case_sensitive: false }
  # validates :body,
  # validates :image,
  # validates :meta_title,
  # validates :meta_description,
  # validates :summary
  # validates :short_description,
  # validates :catchy_title,
  validates :is_published, inclusion: { in: [true, false] }
  validates :published_at, allow_nil: true, :timeliness => { :type => :date}






end
