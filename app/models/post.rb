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
  validates_associated :tags

  #callbacks
  before_validation do
    if self.slug.blank?
      self.slug = self.title.parameterize
    end
  end

  def self.new_with_relations(post_params, category_ids, tags, imdb_id = nil, movie_id = nil)
    post = Post.create!(post_params)

    if category_ids
      post.category_ids = category_ids
    end

    if tags
      tag_ids = find_or_create_tags(tags)
      post.tag_ids = tag_ids
    end

    if imdb_id
      movie = FindCreateImdbMovie.new(imdb_id).call
        if movie
          post.movie = movie
      end
    elsif movie_id
      post.movie = movie_id
    end

    return post
  end


  private

  def self.find_or_create_tags(tags)
    tag_ids = []
    tags.each do |tag|
      tag = Tag.find_or_create_by!(name: tag)
      tag_ids.push(tag.id)
    end
    tag_ids
  end
end
