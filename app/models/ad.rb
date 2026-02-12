class Ad < ApplicationRecord
  belongs_to :movie
  
  validates :title, presence: true, if: :should_validate_fields?
  validates :url, presence: true, if: :should_validate_fields?
  validates :duration, numericality: { greater_than: 0, less_than_or_equal_to: 120 }, if: :should_validate_fields?
  validates :position, inclusion: { in: %w[pre mid post] }, if: :should_validate_fields?
  
  scope :active, -> { where(active: true) }
  scope :by_position, ->(pos) { where(position: pos) }
  
  private
  
  def should_validate_fields?
    # Only validate if the ad has content in required fields
    title.present? || url.present?
  end
end