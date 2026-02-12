class Ad < ApplicationRecord
  belongs_to :movie
  
  validates :title, presence: true
  validates :url, presence: true
  validates :duration, numericality: { greater_than: 0, less_than_or_equal_to: 120 }
  validates :position, inclusion: { in: %w[pre mid post] }
  
  scope :active, -> { where(active: true) }
  scope :by_position, ->(pos) { where(position: pos) }
end
