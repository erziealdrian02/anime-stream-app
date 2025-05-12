import '../../../core/models/anime.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/storage_service.dart';

class AnimeDetailRepository {
  final ApiService _apiService;
  final StorageService _storageService;

  AnimeDetailRepository(this._apiService, this._storageService);

  Future<Anime> getAnimeDetail(String animeId) async {
    // First try to get from API
    try {
      final animeList = await _apiService.getAnimeList();
      final anime = animeList.firstWhere((a) => a.id == animeId);

      // Check if any episodes are downloaded
      final downloadedEpisodes = await _storageService.getDownloadedEpisodes(
        animeId,
      );
      if (downloadedEpisodes.isNotEmpty) {
        // Update episodes with download status
        final updatedEpisodes =
            anime.episodes.map((episode) {
              final downloadedEpisode = downloadedEpisodes.firstWhere(
                (e) => e.id == episode.id,
                orElse: () => episode,
              );
              return downloadedEpisode;
            }).toList();

        return Anime(
          id: anime.id,
          title: anime.title,
          japaneseTitle: anime.japaneseTitle,
          imageUrl: anime.imageUrl,
          status: anime.status,
          score: anime.score,
          duration: anime.duration,
          releaseDate: anime.releaseDate,
          genres: anime.genres,
          synopsis: anime.synopsis,
          episodes: updatedEpisodes,
        );
      }

      return anime;
    } catch (e) {
      // If not found in API, try to get from storage
      final anime = await _storageService.getAnimeById(animeId);
      if (anime != null) {
        return anime;
      }

      // If not found anywhere, rethrow the error
      rethrow;
    }
  }

  Future<void> toggleFavorite(Anime anime) async {
    // Implementation for toggling favorite status
    // This would typically involve saving to local storage or a remote API
  }

  Future<bool> isEpisodeDownloaded(String animeId, String episodeId) async {
    final downloadedEpisodes = await _storageService.getDownloadedEpisodes(
      animeId,
    );
    return downloadedEpisodes.any(
      (episode) => episode.id == episodeId && episode.isDownloaded,
    );
  }
}
