# Movie Streaming Application

A comprehensive movie and TV show streaming platform built with Ruby on Rails, featuring advanced functionality for content management, user engagement, and monetization.

## 🚀 Features

### Content Management
- **Movie & TV Show Management**: Full CRUD operations for movies and TV shows
- **SEO-Friendly URLs**: Clean, readable URLs using the friendly_id gem (e.g., `/movies/the-dark-knight`)
- **Advanced Media Handling**: 
  - Active Storage for thumbnail images and video files
  - Support for multiple image formats (PNG, JPG, JPEG)
  - Support for multiple video formats (MP4, AVI, MOV)
  - File size validation (thumbnails up to 5MB, videos up to 100MB)

### Advertising System
- **Multi-Ad Campaign Support**: Add multiple ads per movie
- **Ad Positioning**: Pre-roll, mid-roll, and post-roll ad placement
- **Ad Frequency Control**: Configurable intervals for mid-roll ads
- **Ad Script Integration**: Support for custom ad scripts and tracking codes
- **Automatic Ad Generation**: Auto-adds sample ads when enabled

### Download Features
- **Download Enable/Disable**: Toggle download availability per movie
- **Quality Options**: HD (1080p), SD (720p), and Mobile (480p) quality settings
- **Flexible Pricing**: Set prices for downloads (free or paid)
- **Secure Downloads**: Protected by user authentication

### User Engagement
- **Rating System**: Users can rate movies from 1-10
- **Favorites System**: Add/remove movies from favorites
- **Search & Filter**: Advanced search by genre, year, rating, and title
- **Pagination**: Kaminari-powered pagination for large datasets

### Responsive Design
- **Professional UI**: Netflix/Prime-inspired design with gradients and animations
- **Mobile-First**: Fully responsive design for all devices
- **Enhanced UX**: Smooth transitions, hover effects, and micro-interactions
- **Dark Theme**: Modern dark interface suitable for media consumption

## 🛠️ Technical Stack

- **Framework**: Ruby on Rails 8.1.2
- **Database**: PostgreSQL
- **Frontend**: Tailwind CSS, Turbo, Stimulus
- **Asset Pipeline**: Propshaft
- **Authentication**: Devise
- **File Storage**: Active Storage with local disk
- **URL Slugging**: FriendlyId gem
- **Pagination**: Kaminari
- **Web Server**: Puma

## 📊 Database Models

### Core Models
- **User**: Authentication and authorization with Devise
- **Movie**: Full movie information with thumbnail and video support
- **TV Show**: TV show information with thumbnail and video support
- **Genre**: Categorization system for content
- **Ad**: Advertising system with positioning and scripting
- **UserMovieRating**: User ratings for movies
- **UserFavorite**: User favorites system

### Key Associations
- Movies and TV Shows belong to Genres
- Users can rate and favorite movies
- Movies and TV Shows can have multiple ads
- Active Storage attachments for thumbnails and videos

## 🏗️ Installation

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd movie_streaming_app
   ```

2. **Install dependencies**:
   ```bash
   bundle install
   ```

3. **Setup database**:
   ```bash
   rails db:create
   rails db:migrate
   ```

4. **Start the server**:
   ```bash
   rails server
   ```

5. **Visit the application**:
   Open your browser to `http://localhost:3000`

## 🎬 Usage Guide

### For Administrators
1. **Access Admin Panel**: Navigate to `/admin` after signing in
2. **Manage Content**: Add, edit, or delete movies and TV shows
3. **Configure Ads**: Set up advertising campaigns with positions and scripts
4. **Set Download Options**: Configure download availability and pricing

### For Users
1. **Browse Content**: Explore movies and TV shows by genre, rating, or search
2. **Rate Content**: Rate movies to contribute to average ratings
3. **Save Favorites**: Mark movies as favorites for easy access
4. **Watch Content**: Stream trailers and full content
5. **Download Content**: Download movies based on availability and pricing

## 🔧 Customization

### Adding New Features
- Extend models in `app/models/`
- Add new controllers in `app/controllers/`
- Customize views in `app/views/`
- Add custom styles in `app/assets/stylesheets/`

### Configuration
- Database configuration: `config/database.yml`
- Application settings: `config/application.rb`
- Routes: `config/routes.rb`
- Initializers: `config/initializers/`

## 📈 SEO Benefits

- **SEO-Friendly URLs**: Clean, descriptive URLs for better search engine visibility
- **Semantic HTML**: Properly structured content for search engines
- **Meta Tags**: Comprehensive meta information
- **Responsive Design**: Mobile-friendly interface

## 💰 Monetization Features

- **Download Pricing**: Set prices for downloadable content
- **Ad Revenue**: Integrated advertising system for revenue generation
- **User Engagement**: Rating and favorite systems to increase retention
- **Premium Content**: Ability to restrict content access

## 🧪 Testing

Run the test suite with:
```bash
rails test
```

Or use the continuous testing feature:
```bash
rails test:run
```

## 🚀 Deployment

The application is configured for Kamal deployment. Update the `config/deploy.yml` file with your server details and deploy with:

```bash
bin/kamal deploy
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new features
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

For support, please open an issue in the GitHub repository or contact the development team.

---

Built with ❤️ using Ruby on Rails