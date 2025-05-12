import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import '../../../config/routes/route_names.dart';
import '../../../shared/widgets/custom_bottom_nav.dart';
import '../../../shared/widgets/error_widget.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../providers/anime_list_providers.dart';
import 'components/alphabet_selector.dart';
import 'components/anime_list_item.dart';

final selectedLetterProvider = StateProvider<String?>((ref) => null);

class AllAnimePage extends ConsumerWidget {
  const AllAnimePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allAnime = ref.watch(allAnimeProvider);
    final selectedLetter = ref.watch(selectedLetterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('All Anime')),
      body: Column(
        children: [
          // Alphabet Selector
          AlphabetSelector(
            selectedLetter: selectedLetter,
            onLetterSelected: (letter) {
              ref.read(selectedLetterProvider.notifier).state = letter;
            },
          ),

          // Anime List
          Expanded(
            child: allAnime.when(
              data: (animeList) {
                // Filter by selected letter if any
                final filteredList =
                    selectedLetter != null
                        ? animeList.where((anime) {
                          final firstLetter =
                              anime.title.isNotEmpty
                                  ? anime.title[0].toUpperCase()
                                  : '';
                          return firstLetter == selectedLetter;
                        }).toList()
                        : animeList;

                if (filteredList.isEmpty) {
                  return Center(
                    child: Text(
                      selectedLetter != null
                          ? 'No anime starting with "$selectedLetter"'
                          : 'No anime found',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  );
                }

                return AnimationLimiter(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final anime = filteredList[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: AnimeListItem(
                              anime: anime,
                              onTap: () {
                                context.goNamed(
                                  RouteNames.animeDetail,
                                  pathParameters: {'animeId': anime.id},
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: LoadingWidget()),
              error:
                  (error, stack) => CustomErrorWidget(
                    message: 'Failed to load anime list',
                    onRetry: () => ref.refresh(allAnimeProvider),
                  ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: 3,
        onTap: (index) {
          switch (index) {
            case 0:
              context.goNamed(RouteNames.home);
              break;
            case 1:
              context.goNamed(RouteNames.downloads);
              break;
            case 2:
              context.goNamed(RouteNames.search);
              break;
            case 3:
              // Already on all anime page
              break;
          }
        },
      ),
    );
  }
}
