import '../../../core/models/anime.dart';
import '../../../core/models/genre.dart';
import '../../../core/services/api_service.dart';

class SearchRepository {
  final ApiService _apiService;

  SearchRepository(this._apiService);

  Future<List<Anime>> searchAnime(String query) async {
    return _apiService.searchAnime(query);
  }

  Future<List<Genre>> getGenres() async {
    return _apiService.getGenres();
  }

  Future<List<Anime>> getAnimeByGenre(String genreId) async {
    return _apiService.getAnimeByGenre(genreId);
  }
}
