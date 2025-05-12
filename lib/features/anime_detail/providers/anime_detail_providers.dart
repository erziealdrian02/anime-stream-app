import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/anime.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/storage_service.dart';
import '../controllers/anime_detail_controller.dart';
import '../repositories/anime_detail_repository.dart';

final animeDetailRepositoryProvider = Provider<AnimeDetailRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  final storageService = ref.watch(storageServiceProvider);
  return AnimeDetailRepository(apiService, storageService);
});

final animeDetailControllerProvider = StateNotifierProvider.family<
  AnimeDetailController,
  AsyncValue<Anime?>,
  String
>((ref, animeId) {
  final repository = ref.watch(animeDetailRepositoryProvider);
  return AnimeDetailController(repository, animeId);
});

final animeDetailProvider = FutureProvider.family<Anime, String>((
  ref,
  animeId,
) async {
  final repository = ref.watch(animeDetailRepositoryProvider);
  return repository.getAnimeDetail(animeId);
});

final isEpisodeDownloadedProvider =
    FutureProvider.family<bool, Map<String, String>>((ref, params) async {
      final animeId = params['animeId'] ?? '';
      final episodeId = params['episodeId'] ?? '';
      final repository = ref.watch(animeDetailRepositoryProvider);
      return repository.isEpisodeDownloaded(animeId, episodeId);
    });

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});
