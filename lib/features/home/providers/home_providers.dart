import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/anime.dart';
import '../../../core/services/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final ongoingAnimeProvider = FutureProvider<List<Anime>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getOngoingAnime();
});

final completedAnimeProvider = FutureProvider<List<Anime>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getCompletedAnime();
});

final popularAnimeProvider = FutureProvider<List<Anime>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getPopularAnime();
});

final moviesProvider = FutureProvider<List<Anime>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getMovies();
});

final carouselItemsProvider = FutureProvider<List<Anime>>((ref) async {
  final popularAnime = await ref.watch(popularAnimeProvider.future);
  // Mengambil 5 anime populer untuk carousel
  return popularAnime.take(5).toList();
});
