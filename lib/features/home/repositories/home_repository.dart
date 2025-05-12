import '../../../core/models/anime.dart';
import '../../../core/services/api_service.dart';

class HomeRepository {
  final ApiService _apiService;

  HomeRepository(this._apiService);

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
}
