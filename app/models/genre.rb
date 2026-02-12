class Genre < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  has_many :movies, dependent: :nullify
  has_many :tv_shows, dependent: :nullify
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
