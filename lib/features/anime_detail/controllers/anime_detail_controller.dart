import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/anime.dart';
import '../repositories/anime_detail_repository.dart';

class AnimeDetailController extends StateNotifier<AsyncValue<Anime?>> {
  final AnimeDetailRepository _repository;
  final String animeId;

  AnimeDetailController(this._repository, this.animeId)
    : super(const AsyncValue.loading()) {
    loadAnimeDetail();
  }

  Future<void> loadAnimeDetail() async {
    try {
      state = const AsyncValue.loading();
      final anime = await _repository.getAnimeDetail(animeId);
      state = AsyncValue.data(anime);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> toggleFavorite() async {
    final currentAnime = state.value;
    if (currentAnime == null) return;

    try {
      await _repository.toggleFavorite(currentAnime);
      loadAnimeDetail(); // Reload to get updated state
    } catch (e) {
      // Handle error
    }
  }

  Future<bool> isEpisodeDownloaded(String episodeId) async {
    return _repository.isEpisodeDownloaded(animeId, episodeId);
  }
}
