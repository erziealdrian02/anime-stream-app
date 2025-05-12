class ApiConstants {
  static const String baseUrl = 'https://wenime-api.vercel.app/samehadaku';

  // Endpoints
  static const String ongoing = '/ongoing';
  static const String completed = '/completed';
  static const String popular = '/popular';
  static const String movies = '/movies';
  static const String search = '/search';
  static const String schedule = '/schedule';
  static const String genres = '/genres';
  static const String anime = '/anime';

  // Construct URLs
  static String getOngoingUrl() => '$baseUrl$ongoing';
  static String getCompletedUrl() => '$baseUrl$completed';
  static String getPopularUrl() => '$baseUrl$popular';
  static String getMoviesUrl() => '$baseUrl$movies';
  static String getSearchUrl(String query) => '$baseUrl$search?q=$query';
  static String getScheduleUrl() => '$baseUrl$schedule';
  static String getGenresUrl() => '$baseUrl$genres';
  static String getAnimeListUrl() => '$baseUrl$anime';
  static String getGenreDetailUrl(String genreId) => '$baseUrl$genres/$genreId';
}
