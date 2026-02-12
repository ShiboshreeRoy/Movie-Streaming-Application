class Ad < ApplicationRecord
  belongs_to :advertisable, polymorphic: true
  
  # Additional fields for site-wide ads
  # Using constants instead of enum for placement_zone due to compatibility issues
  PLACEMENT_ZONES = {
    header: 0, 
    sidebar: 1, 
    footer: 2, 
    content: 3, 
    popup: 4, 
    interstitial: 5,
    home_page: 6,
    movie_page: 7,
    tv_show_page: 8,
    category_page: 9
  }.freeze
  
  validates :title, presence: true, if: :should_validate_fields?
  validates :url, presence: true, if: :should_validate_fields?
  validates :duration, numericality: { greater_than: 0, less_than_or_equal_to: 120 }, if: :should_validate_fields?
  validates :position, inclusion: { in: %w[pre mid post] }, if: :should_validate_fields?
  # Removed placement_zone validation since it's stored as integer and we handle mapping in the model
  
  scope :active, -> { where(active: true) }
  scope :by_position, ->(pos) { where(position: pos) }
  scope :by_placement_zone, ->(zone) { where(placement_zone: zone) }
  scope :by_priority, -> { order(priority: :desc) }
  
  def self.placement_zones
    PLACEMENT_ZONES
  end
  
  def placement_zone_label
    PLACEMENT_ZONES.key(placement_zone&.to_i)&.to_s&.humanize
  end
  
  def placement_zone_name
    PLACEMENT_ZONES.key(placement_zone&.to_i)&.to_s
  end
  
  private
  
  def should_validate_fields?
    # Only validate if the ad has content in required fields
    title.present? || url.present?
  end
end