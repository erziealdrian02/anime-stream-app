import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/anime.dart';
import '../../../core/models/episode.dart';
import '../repositories/download_repository.dart';

class DownloadController extends StateNotifier<AsyncValue<List<Anime>>> {
  final DownloadRepository _repository;

  DownloadController(this._repository) : super(const AsyncValue.loading()) {
    loadDownloadedAnime();
  }

  Future<void> loadDownloadedAnime() async {
    try {
      state = const AsyncValue.loading();
      final downloadedAnime = await _repository.getDownloadedAnime();
      state = AsyncValue.data(downloadedAnime);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<List<Episode>> getDownloadedEpisodes(String animeId) async {
    return _repository.getDownloadedEpisodes(animeId);
  }

  Future<void> downloadEpisode(
    Anime anime,
    Episode episode,
    Function(double) onProgress,
  ) async {
    try {
      await _repository.downloadEpisode(anime, episode, onProgress);
      loadDownloadedAnime(); // Refresh the list
    } catch (e) {
      // Handle error
    }
  }

  Future<void> deleteDownloadedEpisode(String animeId, Episode episode) async {
    try {
      await _repository.deleteDownloadedEpisode(animeId, episode);
      loadDownloadedAnime(); // Refresh the list
    } catch (e) {
      // Handle error
    }
  }
}
