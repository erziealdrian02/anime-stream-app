import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/anime.dart';
import '../repositories/anime_list_repository.dart';

class AnimeListController extends StateNotifier<AsyncValue<List<Anime>>> {
  final AnimeListRepository _repository;

  AnimeListController(this._repository) : super(const AsyncValue.loading()) {
    loadAnimeList();
  }

  Future<void> loadAnimeList() async {
    try {
      state = const AsyncValue.loading();
      final animeList = await _repository.getAnimeList();
      state = AsyncValue.data(animeList);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<List<Anime>> getAnimeBySection(String sectionType) async {
    try {
      if (sectionType.startsWith('genre_')) {
        final genreId = sectionType.replaceFirst('genre_', '');
        return await _repository.getAnimeByGenre(genreId);
      }

      switch (sectionType) {
        case 'ongoing':
          return await _repository.getOngoingAnime();
        case 'completed':
          return await _repository.getCompletedAnime();
        case 'popular':
          return await _repository.getPopularAnime();
        case 'movies':
          return await _repository.getMovies();
        default:
          return [];
      }
    } catch (e) {
      return [];
    }
  }

  List<String> getAlphabetList() {
    return state.when(
      data: (animeList) {
        final Set<String> letters = {};
        for (final anime in animeList) {
          if (anime.title.isNotEmpty) {
            letters.add(anime.title[0].toUpperCase());
          }
        }
        final sortedLetters = letters.toList()..sort();
        return sortedLetters;
      },
      loading: () => [],
      error: (_, __) => [],
    );
  }

  List<Anime> getAnimeByLetter(String letter) {
    return state.when(
      data: (animeList) {
        return animeList.where((anime) {
          if (anime.title.isNotEmpty) {
            return anime.title[0].toUpperCase() == letter;
          }
          return false;
        }).toList();
      },
      loading: () => [],
      error: (_, __) => [],
    );
  }
}
