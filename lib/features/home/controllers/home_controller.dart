import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/anime.dart';
import '../repositories/home_repository.dart';

class HomeController
    extends StateNotifier<AsyncValue<Map<String, List<Anime>>>> {
  final HomeRepository _repository;

  HomeController(this._repository) : super(const AsyncValue.loading()) {
    loadHomeData();
  }

  Future<void> loadHomeData() async {
    try {
      state = const AsyncValue.loading();

      // Load all data in parallel
      final ongoingFuture = _repository.getOngoingAnime();
      final completedFuture = _repository.getCompletedAnime();
      final popularFuture = _repository.getPopularAnime();
      final moviesFuture = _repository.getMovies();

      final results = await Future.wait([
        ongoingFuture,
        completedFuture,
        popularFuture,
        moviesFuture,
      ]);

      final data = {
        'ongoing': results[0],
        'completed': results[1],
        'popular': results[2],
        'movies': results[3],
      };

      state = AsyncValue.data(data);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  List<Anime> getCarouselItems() {
    return state.when(
      data: (data) {
        final popular = data['popular'] ?? [];
        return popular.take(5).toList();
      },
      loading: () => [],
      error: (_, __) => [],
    );
  }

  List<Anime> getAnimeBySection(String section) {
    return state.when(
      data: (data) {
        return data[section] ?? [];
      },
      loading: () => [],
      error: (_, __) => [],
    );
  }
}
