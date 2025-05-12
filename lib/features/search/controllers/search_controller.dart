import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/anime.dart';
import '../../../core/models/genre.dart';
import '../repositories/search_repository.dart';

class SearchController extends StateNotifier<AsyncValue<List<Anime>>> {
  final SearchRepository _repository;
  String _lastQuery = '';

  SearchController(this._repository) : super(const AsyncValue.loading());

  Future<void> searchAnime(String query) async {
    if (query.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    if (query == _lastQuery) return;
    _lastQuery = query;

    try {
      state = const AsyncValue.loading();
      final results = await _repository.searchAnime(query);
      state = AsyncValue.data(results);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  void clearSearch() {
    _lastQuery = '';
    state = const AsyncValue.data([]);
  }
}

class GenresController extends StateNotifier<AsyncValue<List<Genre>>> {
  final SearchRepository _repository;

  GenresController(this._repository) : super(const AsyncValue.loading()) {
    loadGenres();
  }

  Future<void> loadGenres() async {
    try {
      state = const AsyncValue.loading();
      final genres = await _repository.getGenres();
      state = AsyncValue.data(genres);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
