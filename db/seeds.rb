# Create genres
genres_data = [
  { name: "Action" },
  { name: "Comedy" },
  { name: "Drama" },
  { name: "Horror" },
  { name: "Romance" },
  { name: "Sci-Fi" },
  { name: "Thriller" },
  { name: "Crime" },
  { name: "Adventure" },
  { name: "Fantasy" },
  { name: "Mystery" }
]

genres_data.each do |genre_data|
  Genre.find_or_create_by(name: genre_data[:name]) do |genre|
    genre.name = genre_data[:name]
  end
end

puts "Created #{Genre.count} genres"

# Create sample movies
movies_data = [
  {
    title: "Inception",
    description: "A thief who steals corporate secrets through dream-sharing technology is given the task of planting an idea into the mind of a C.E.O.",
    genre: Genre.find_by(name: "Action"),
    duration: 148,
    release_year: 2010,
    imdb_rating: 8.8,
    poster_url: "https://via.placeholder.com/300x450/1a202c/FFFFFF?text=Inception",
    trailer_url: "https://www.youtube.com/watch?v=YoHD9XEInc0",
    country: "USA",
    director: "Christopher Nolan",
    cast: "Leonardo DiCaprio, Joseph Gordon-Levitt, Elliot Page, Tom Hardy"
  },
  {
    title: "The Shawshank Redemption",
    description: "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.",
    genre: Genre.find_by(name: "Drama"),
    duration: 142,
    release_year: 1994,
    imdb_rating: 9.3,
    poster_url: "https://via.placeholder.com/300x450/1a202c/FFFFFF?text=Shawshank",
    trailer_url: "https://www.youtube.com/watch?v=6hB3S9bIaco",
    country: "USA",
    director: "Frank Darabont",
    cast: "Tim Robbins, Morgan Freeman, Bob Gunton"
  },
  {
    title: "The Dark Knight",
    description: "When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
    genre: Genre.find_by(name: "Action"),
    duration: 152,
    release_year: 2008,
    imdb_rating: 9.0,
    poster_url: "https://via.placeholder.com/300x450/1a202c/FFFFFF?text=Dark+Knight",
    trailer_url: "https://www.youtube.com/watch?v=EXeTwQWrcwY",
    country: "USA",
    director: "Christopher Nolan",
    cast: "Christian Bale, Heath Ledger, Aaron Eckhart"
  },
  {
    title: "Pulp Fiction",
    description: "The lives of two mob hitmen, a boxer, a gangster and his wife intertwine in four tales of violence and redemption.",
    genre: Genre.find_by(name: "Crime"),
    duration: 154,
    release_year: 1994,
    imdb_rating: 8.9,
    poster_url: "https://via.placeholder.com/300x450/1a202c/FFFFFF?text=Pulp+Fiction",
    trailer_url: "https://www.youtube.com/watch?v=s7EdQ4FqbhY",
    country: "USA",
    director: "Quentin Tarantino",
    cast: "John Travolta, Uma Thurman, Samuel L. Jackson"
  },
  {
    title: "Forrest Gump",
    description: "The presidencies of Kennedy and Johnson, the events of Vietnam, Watergate, and other historical events unfold through the perspective of an Alabama man with an IQ of 75.",
    genre: Genre.find_by(name: "Drama"),
    duration: 142,
    release_year: 1994,
    imdb_rating: 8.8,
    poster_url: "https://via.placeholder.com/300x450/1a202c/FFFFFF?text=Forrest+Gump",
    trailer_url: "https://www.youtube.com/watch?v=bLvqoHBptjg",
    country: "USA",
    director: "Robert Zemeckis",
    cast: "Tom Hanks, Robin Wright, Gary Sinise"
  }
]

movies_data.each do |movie_data|
  Movie.find_or_create_by(title: movie_data[:title]) do |movie|
    movie.attributes = movie_data
  end
end

puts "Created #{Movie.count} movies"

# Create sample TV shows
tv_shows_data = [
  {
    title: "Breaking Bad",
    description: "A high school chemistry teacher diagnosed with inoperable lung cancer turns to manufacturing and selling methamphetamine in order to secure his family's future.",
    genre: Genre.find_by(name: "Crime"),
    seasons: 5,
    episodes: 62,
    release_year: 2008,
    imdb_rating: 9.5,
    poster_url: "https://via.placeholder.com/300x450/1a202c/FFFFFF?text=Breaking+Bad",
    trailer_url: "https://www.youtube.com/watch?v=XZ8daibM3AI",
    country: "USA"
  },
  {
    title: "Game of Thrones",
    description: "Nine noble families fight for control over the lands of Westeros, while an ancient enemy returns after being dormant for millennia.",
    genre: Genre.find_by(name: "Fantasy"),
    seasons: 8,
    episodes: 73,
    release_year: 2011,
    imdb_rating: 9.2,
    poster_url: "https://via.placeholder.com/300x450/1a202c/FFFFFF?text=GoT",
    trailer_url: "https://www.youtube.com/watch?v=BpJYNVhGf1s",
    country: "USA"
  },
  {
    title: "Stranger Things",
    description: "When a young boy disappears, his mother, a police chief, and his friends must confront terrifying forces in order to get him back.",
    genre: Genre.find_by(name: "Horror"),
    seasons: 4,
    episodes: 34,
    release_year: 2016,
    imdb_rating: 8.7,
    poster_url: "https://via.placeholder.com/300x450/1a202c/FFFFFF?text=Stranger+Things",
    trailer_url: "https://www.youtube.com/watch?v=XWxyRG_tckg",
    country: "USA"
  }
]

tv_shows_data.each do |tv_show_data|
  TvShow.find_or_create_by(title: tv_show_data[:title]) do |tv_show|
    tv_show.attributes = tv_show_data
  end
end

puts "Created #{TvShow.count} TV shows"

# Create a sample admin user
admin_user = User.find_or_create_by(email: 'admin@example.com') do |user|
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.first_name = 'Admin'
  user.last_name = 'User'
  user.role = 1  # Admin role
end

puts "Admin user created with email: admin@example.com and password: password123"

# Create a sample regular user
regular_user = User.find_or_create_by(email: 'user@example.com') do |user|
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.first_name = 'Regular'
  user.last_name = 'User'
  user.role = 0  # User role
end

puts "Regular user created with email: user@example.com and password: password123"
