class Movie < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  belongs_to :user, optional: true
  belongs_to :genre, optional: true
  has_many :user_movie_ratings, dependent: :destroy
  has_many :user_favorites, dependent: :destroy
  has_many :ads, dependent: :destroy
  has_many :rated_users, through: :user_movie_ratings, source: :user
  has_many :favorited_users, through: :user_favorites, source: :user
  
  # Active Storage attachments
  has_one_attached :thumbnail
  has_one_attached :video
  
  # Accept nested attributes for ads - reject if title or url are blank
  accepts_nested_attributes_for :ads, allow_destroy: true, reject_if: proc { |attributes|
    attributes['title'].blank? || attributes['url'].blank?
  }
  
  validates :title, presence: true
  validates :release_year, numericality: { greater_than: 1900, less_than_or_equal_to: Date.current.year + 5 }
  
  # Custom validations for content types and sizes
  validate :validate_thumbnail_content_type
  validate :validate_video_content_type
  validate :validate_thumbnail_size
  validate :validate_video_size
  
  scope :by_genre, ->(genre_id) { where(genre_id: genre_id) }
  scope :by_year, ->(year) { where(release_year: year) }
  scope :by_rating, ->(min_rating) { where('imdb_rating >= ?', min_rating) }
  scope :recent, -> { order(created_at: :desc) }
  scope :popular, -> { left_joins(:user_favorites).group(:id).order('COUNT(user_favorites.id) DESC') }
  scope :most_viewed, -> { order(views_count: :desc) }
  scope :most_downloaded, -> { order(downloads_count: :desc) }
  
  # Override poster_url to use attached thumbnail if available
  def display_poster_url
    if thumbnail.attached? && persisted? && thumbnail.persisted?
      Rails.application.routes.url_helpers.rails_blob_url(thumbnail, only_path: true)
    else
      poster_url
    end
  end
  
  # Override trailer_url to use attached video if available
  def display_video_url
    if video.attached? && persisted? && video.persisted?
      Rails.application.routes.url_helpers.rails_blob_url(video, only_path: true)
    else
      trailer_url
    end
  end
  
  # Tracking methods
  def increment_views!
    increment!(:views_count)
  end
  
  def increment_downloads!
    increment!(:downloads_count)
  end
  
  def total_engagement
    views_count.to_i + downloads_count.to_i
  end
  
  private
  
  def validate_thumbnail_content_type
    if thumbnail.attached? && !thumbnail.content_type.in?(%w[image/png image/jpg image/jpeg])
      errors.add(:thumbnail, 'must be a PNG, JPG, or JPEG image')
    end
  end
  
  def validate_video_content_type
    if video.attached? && !video.content_type.in?(%w[video/mp4 video/avi video/mov video/quicktime])
      errors.add(:video, 'must be an MP4, AVI, or MOV video')
    end
  end
  
  def validate_thumbnail_size
    if thumbnail.attached? && thumbnail.blob.byte_size > 5.megabytes
      errors.add(:thumbnail, 'must be less than 5MB')
    end
  end
  
  def validate_video_size
    if video.attached? && video.blob.byte_size > 100.megabytes
      errors.add(:video, 'must be less than 100MB')
    end
  end
end