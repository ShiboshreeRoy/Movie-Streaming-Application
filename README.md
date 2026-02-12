# Movie Streaming Application

A comprehensive movie, TV show, and web series streaming platform built with Ruby on Rails, featuring advanced functionality for content management, user engagement, monetization, and professional streaming capabilities.

## 🚀 Features

### Content Management
- **Multi-Content Support**: Full CRUD operations for Movies, TV Shows, and Web Series
- **SEO-Friendly URLs**: Clean, readable URLs using the friendly_id gem (e.g., `/movies/the-dark-knight`)
- **Advanced Media Handling**: 
  - Active Storage for thumbnail images and video files
  - Support for multiple image formats (PNG, JPG, JPEG)
  - Support for multiple video formats (MP4, AVI, MOV)
  - File size validation (thumbnails up to 5MB, videos up to 500MB)
- **Professional Content Organization**: 
  - Season and episode management for web series
  - Genre-based categorization
  - Release date and duration tracking
  - View and download counters

### Advanced Streaming System
- **Direct Video Playback**: Access any content directly via `?watch=true` parameter
- **Dedicated Video Players**: Full-screen 16:9 video players for all content types
- **Responsive Streaming**: Works seamlessly on desktop, tablet, and mobile devices
- **Video Quality Options**: HD, SD, Mobile, and 4K quality settings
- **Professional UI/UX**: Netflix/Prime-inspired player interface

### Advertising System
- **Multi-Ad Campaign Support**: Add multiple ads per content item
- **Ad Positioning**: Pre-roll, mid-roll, and post-roll ad placement
- **Ad Frequency Control**: Configurable intervals for mid-roll ads
- **Ad Script Integration**: Support for custom ad scripts and tracking codes
- **Automatic Ad Generation**: Auto-adds sample ads when enabled
- **Polymorphic Ad Support**: Single ad system works for Movies, TV Shows, and Web Series

### Download Features
- **Download Enable/Disable**: Toggle download availability per content item
- **Quality Options**: HD (1080p), SD (720p), Mobile (480p), and 4K quality settings
- **Flexible Pricing**: Set prices for downloads (free or paid)
- **Secure Downloads**: Protected by user authentication
- **Download Tracking**: Monitor download statistics

### User Engagement
- **Rating System**: Users can rate content from 1-10
- **Favorites System**: Add/remove content from favorites
- **Search & Filter**: Advanced search by genre, year, rating, season, and title
- **Pagination**: Kaminari-powered pagination for large datasets
- **User Analytics**: Track viewing history and engagement metrics

### Admin Dashboard
- **Comprehensive Analytics**: Real-time statistics for views, downloads, and engagement
- **Content Management**: Unified interface for Movies, TV Shows, and Web Series
- **User Management**: Monitor and manage user accounts
- **Ad Management**: Create and configure advertising campaigns
- **Performance Monitoring**: Track content performance and user engagement

### Responsive Design
- **Professional UI**: Netflix/Prime-inspired design with gradients and animations
- **Mobile-First**: Fully responsive design for all devices
- **Enhanced UX**: Smooth transitions, hover effects, and micro-interactions
- **Dark Theme**: Modern dark interface suitable for media consumption
- **Premium Components**: Separate shared navbar and footer components

### Authentication & Security
- **User Authentication**: Secure Devise-based authentication system
- **Role-Based Access**: Admin and regular user roles
- **Session Tracking**: Monitor user activity and engagement
- **Secure File Handling**: Protected media content delivery

## 🛠️ Technical Stack

- **Framework**: Ruby on Rails 8.1.2
- **Database**: PostgreSQL
- **Frontend**: Tailwind CSS, Turbo, Stimulus
- **Asset Pipeline**: Propshaft
- **Authentication**: Devise with trackable module
- **File Storage**: Active Storage with local disk
- **URL Slugging**: FriendlyId gem
- **Pagination**: Kaminari
- **Web Server**: Puma
- **Admin Interface**: Custom admin panel with analytics
- **Video Streaming**: HTML5 video players with responsive design

## 📊 Database Models

### Core Models
- **User**: Authentication and authorization with Devise (trackable module enabled)
- **Movie**: Full movie information with thumbnail and video support
- **TV Show**: TV show information with thumbnail and video support
- **Web Series**: Episode-based content with season/episode tracking
- **Genre**: Categorization system for all content types
- **Ad**: Polymorphic advertising system with positioning and scripting
- **UserMovieRating**: User ratings for content
- **UserFavorite**: User favorites system

### Key Associations
- All content types (Movies, TV Shows, Web Series) belong to Genres
- Users can rate and favorite content
- Polymorphic relationship between content and Ads
- Active Storage attachments for thumbnails and videos
- Trackable user sessions and engagement metrics

## 🏗️ Installation

1. **Clone the repository**:
   ```bash
   git clone  https://github.com/ShiboshreeRoy/Movie-Streaming-Application.git
   cd Movie-Streaming-Application
   ```

2. **Install dependencies**:
   ```bash
   bundle install
   ```

3. **Setup database**:
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
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
2. **Manage Content**: Add, edit, or delete Movies, TV Shows, and Web Series
3. **Configure Ads**: Set up advertising campaigns with positions and scripts
4. **Set Download Options**: Configure download availability and pricing
5. **Monitor Analytics**: View real-time statistics and content performance
6. **User Management**: Manage user accounts and permissions

### For Users
1. **Browse Content**: Explore Movies, TV Shows, and Web Series by genre, rating, or search
2. **Direct Streaming**: Access any content directly via `?watch=true` parameter
3. **Rate Content**: Rate content to contribute to average ratings
4. **Save Favorites**: Mark content as favorites for easy access
5. **Watch Content**: Stream trailers and full content in dedicated video players
6. **Download Content**: Download content based on availability and pricing
7. **Search & Filter**: Use advanced filtering options to find specific content

### Direct Video Access URLs
- **Movies**: `/movies/:id?watch=true`
- **TV Shows**: `/tv_shows/:id?watch=true`
- **Web Series**: `/web_series/:id?watch=true`

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
- Admin settings: `app/views/layouts/admin.html.erb`

## 📈 SEO Benefits

- **SEO-Friendly URLs**: Clean, descriptive URLs for better search engine visibility
- **Semantic HTML**: Properly structured content for search engines
- **Meta Tags**: Comprehensive meta information
- **Responsive Design**: Mobile-friendly interface
- **Fast Loading**: Optimized assets and caching

## 💰 Monetization Features

- **Download Pricing**: Set prices for downloadable content
- **Ad Revenue**: Integrated advertising system for revenue generation
- **User Engagement**: Rating and favorite systems to increase retention
- **Premium Content**: Ability to restrict content access
- **Analytics Dashboard**: Track revenue and engagement metrics

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
