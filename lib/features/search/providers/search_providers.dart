import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/anime.dart';
import '../../../core/models/genre.dart';
import '../../../core/services/api_service.dart';
import '../controllers/search_controller.dart';
import '../repositories/search_repository.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return SearchRepository(apiService);
});

final searchControllerProvider =
    StateNotifierProvider<SearchController, AsyncValue<List<Anime>>>((ref) {
      final repository = ref.watch(searchRepositoryProvider);
      return SearchController(repository);
    });

final genresControllerProvider =
    StateNotifierProvider<GenresController, AsyncValue<List<Genre>>>((ref) {
      final repository = ref.watch(searchRepositoryProvider);
      return GenresController(repository);
    });

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultsProvider = FutureProvider<List<Anime>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return [];

  final repository = ref.watch(searchRepositoryProvider);
  return repository.searchAnime(query);
});

final genresProvider = FutureProvider<List<Genre>>((ref) async {
  final repository = ref.watch(searchRepositoryProvider);
  return repository.getGenres();
});

final animeByGenreProvider = FutureProvider.family<List<Anime>, String>((
  ref,
  genreId,
) async {
  final repository = ref.watch(searchRepositoryProvider);
  return repository.getAnimeByGenre(genreId);
});
