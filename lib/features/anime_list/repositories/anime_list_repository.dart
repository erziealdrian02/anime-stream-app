import '../../../core/models/anime.dart';
import '../../../core/services/api_service.dart';

class AnimeListRepository {
  final ApiService _apiService;

  AnimeListRepository(this._apiService);

  Future<List<Anime>> getAnimeList() async {
    return _apiService.getAnimeList();
  }

  Future<List<Anime>> getOngoingAnime() async {
    return _apiService.getOngoingAnime();
  }

  Future<List<Anime>> getCompletedAnime() async {
    return _apiService.getCompletedAnime();
  }

  Future<List<Anime>> getPopularAnime() async {
    return _apiService.getPopularAnime();
  }

  Future<List<Anime>> getMovies() async {
    return _apiService.getMovies();
  }

  Future<List<Anime>> getAnimeByGenre(String genreId) async {
    return _apiService.getAnimeByGenre(genreId);
  }
}
