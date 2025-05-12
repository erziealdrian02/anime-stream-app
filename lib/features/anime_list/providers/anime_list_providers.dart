import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/anime.dart';
import '../../../core/services/api_service.dart';
import '../controllers/anime_list_controller.dart';
import '../repositories/anime_list_repository.dart';

final animeListRepositoryProvider = Provider<AnimeListRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return AnimeListRepository(apiService);
});

final animeListControllerProvider =
    StateNotifierProvider<AnimeListController, AsyncValue<List<Anime>>>((ref) {
      final repository = ref.watch(animeListRepositoryProvider);
      return AnimeListController(repository);
    });

final allAnimeProvider = FutureProvider<List<Anime>>((ref) async {
  final repository = ref.watch(animeListRepositoryProvider);
  return repository.getAnimeList();
});

final sectionAnimeProvider = FutureProvider.family<List<Anime>, String>((
  ref,
  sectionType,
) async {
  final controller = ref.watch(animeListControllerProvider.notifier);
  return controller.getAnimeBySection(sectionType);
});

final alphabetListProvider = Provider<List<String>>((ref) {
  final controller = ref.watch(animeListControllerProvider.notifier);
  return controller.getAlphabetList();
});

final animeByLetterProvider = Provider.family<List<Anime>, String>((
  ref,
  letter,
) {
  final controller = ref.watch(animeListControllerProvider.notifier);
  return controller.getAnimeByLetter(letter);
});
