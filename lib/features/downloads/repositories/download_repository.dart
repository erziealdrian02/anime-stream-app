import '../../../core/models/anime.dart';
import '../../../core/models/episode.dart';
import '../../../core/services/download_service.dart';
import '../../../core/services/storage_service.dart';

class DownloadRepository {
  final DownloadService _downloadService;
  final StorageService _storageService;

  DownloadRepository(this._downloadService, this._storageService);

  Future<List<Anime>> getDownloadedAnime() async {
    return _downloadService.getDownloadedAnime();
  }

  Future<List<Episode>> getDownloadedEpisodes(String animeId) async {
    return _downloadService.getDownloadedEpisodes(animeId);
  }

  Future<Episode> downloadEpisode(
    Anime anime,
    Episode episode,
    Function(double) onProgress,
  ) async {
    return _downloadService.downloadEpisode(
      anime: anime,
      episode: episode,
      onProgress: onProgress,
    );
  }

  Future<void> deleteDownloadedEpisode(String animeId, Episode episode) async {
    return _downloadService.deleteDownloadedEpisode(animeId, episode);
  }
}
