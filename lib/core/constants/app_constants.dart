class AppConstants {
  // API Endpoints
  static const String baseUrl = 'https://anime-api.example.com';
  static const String animeListEndpoint = '/anime/list';
  static const String ongoingAnimeEndpoint = '/anime/ongoing';
  static const String completedAnimeEndpoint = '/anime/completed';
  static const String popularAnimeEndpoint = '/anime/popular';
  static const String moviesEndpoint = '/anime/movies';
  static const String genresEndpoint = '/genres';
  static const String scheduleEndpoint = '/schedule';
  static const String searchEndpoint = '/search';

  // App Settings
  static const String appName = 'Anime Stream';
  static const String appVersion = '1.0.0';
  static const int cacheExpirationMinutes = 30;

  // Storage Keys
  static const String themePreferenceKey = 'theme_preference';
  static const String userTokenKey = 'user_token';
  static const String recentSearchesKey = 'recent_searches';
  static const String watchHistoryKey = 'watch_history';
  static const String favoriteAnimeKey = 'favorite_anime';

  // Pagination
  static const int defaultPageSize = 20;

  // Animation Durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration pageTransitionDuration = Duration(milliseconds: 200);

  // Video Player
  static const List<String> supportedVideoFormats = ['mp4', 'mkv', 'webm'];
  static const List<String> supportedQualityOptions = [
    '1080p',
    '720p',
    '480p',
    '360p',
  ];
  static const int defaultBufferDurationMs = 5000;

  // Download Settings
  static const int maxConcurrentDownloads = 3;
  static const int downloadChunkSize = 1024 * 1024; // 1MB

  // UI Constants
  static const double bottomNavBarHeight = 60.0;
  static const double carouselAspectRatio = 16 / 9;
  static const double animeCardAspectRatio = 2 / 3;
  static const double defaultPadding = 16.0;
  static const double cornerRadius = 12.0;

  // Error Messages
  static const String networkErrorMessage =
      'Network error. Please check your connection and try again.';
  static const String serverErrorMessage =
      'Server error. Please try again later.';
  static const String notFoundErrorMessage =
      'The requested content was not found.';
  static const String defaultErrorMessage =
      'Something went wrong. Please try again.';
}
