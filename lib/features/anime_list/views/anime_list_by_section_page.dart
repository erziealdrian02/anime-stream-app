import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import '../../../config/routes/route_names.dart';
import '../../../shared/widgets/error_widget.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../providers/anime_list_providers.dart';
import 'components/anime_list_item.dart';

class AnimeListBySectionPage extends ConsumerWidget {
  final String sectionType;
  final String sectionTitle;

  const AnimeListBySectionPage({
    super.key,
    required this.sectionType,
    required this.sectionTitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animeList = ref.watch(sectionAnimeProvider(sectionType));

    return Scaffold(
      appBar: AppBar(title: Text(sectionTitle)),
      body: animeList.when(
        data: (data) {
          return AnimationLimiter(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final anime = data[index];
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
              onRetry: () => ref.refresh(sectionAnimeProvider(sectionType)),
            ),
      ),
    );
  }
}
