class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  
  # Role constants
  ROLES = { user: 0, admin: 1 }.freeze
  
  has_many :user_movie_ratings, dependent: :destroy
  has_many :user_favorites, dependent: :destroy
  has_many :rated_movies, through: :user_movie_ratings, source: :movie
  has_many :favorite_movies, through: :user_favorites, source: :movie
  
  validates :first_name, length: { maximum: 50 }
  validates :last_name, length: { maximum: 50 }
  
  def admin?
    role == 1
  end
  
  def user?
    role == 0
  end
  
  def full_name
    "#{first_name} #{last_name}".strip
  end
end
