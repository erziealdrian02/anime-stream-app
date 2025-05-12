import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/anime.dart';
import '../../../core/models/episode.dart';
import '../../../core/services/download_service.dart';
import '../../../core/services/storage_service.dart';
import '../controllers/download_controller.dart';
import '../repositories/download_repository.dart';

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

final downloadServiceProvider = Provider<DownloadService>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  return DownloadService(storageService: storageService);
});

final downloadRepositoryProvider = Provider<DownloadRepository>((ref) {
  final downloadService = ref.watch(downloadServiceProvider);
  return DownloadRepository(downloadService);
});

final downloadControllerProvider =
    StateNotifierProvider<DownloadController, AsyncValue<List<Anime>>>((ref) {
      final repository = ref.watch(downloadRepositoryProvider);
      return DownloadController(repository);
    });

final downloadedAnimeProvider = FutureProvider<List<Anime>>((ref) async {
  final repository = ref.watch(downloadRepositoryProvider);
  return repository.getDownloadedAnime();
});

final downloadedEpisodesProvider = FutureProvider.family<List<Episode>, String>(
  (ref, animeId) async {
    final repository = ref.watch(downloadRepositoryProvider);
    return repository.getDownloadedEpisodes(animeId);
  },
);
