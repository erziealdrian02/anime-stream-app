import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/routes/route_names.dart';
import '../../../config/theme/app_colors.dart';
import '../../../shared/widgets/error_widget.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/rating_stars.dart';
import '../providers/anime_detail_providers.dart';
import 'components/anime_info_section.dart';
import 'components/episode_list.dart';
import 'components/synopsis_section.dart';

class AnimeDetailPage extends ConsumerWidget {
  final String animeId;

  const AnimeDetailPage({super.key, required this.animeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animeDetail = ref.watch(animeDetailProvider(animeId));

    return Scaffold(
      body: animeDetail.when(
        data: (anime) {
          return CustomScrollView(
            slivers: [
              // App Bar with Image
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(anime.imageUrl, fit: BoxFit.cover),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                              Colors.black,
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              anime.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (anime.japaneseTitle.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                anime.japaneseTitle,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(anime.status),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    anime.status,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                RatingStars(rating: anime.score),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                leading: IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.share),
                    ),
                    onPressed: () {
                      // Share functionality
                    },
                  ),
                ],
              ),

              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Play first episode
                                if (anime.episodes.isNotEmpty) {
                                  context.goNamed(
                                    RouteNames.videoPlayer,
                                    queryParameters: {
                                      'videoUrl': anime.episodes.first.url,
                                      'title': anime.title,
                                      'episodeNumber':
                                          anime.episodes.first.number,
                                    },
                                  );
                                }
                              },
                              icon: const Icon(Icons.play_arrow),
                              label: const Text('Play'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryBlue,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          OutlinedButton.icon(
                            onPressed: () {
                              // Add to downloads
                            },
                            icon: const Icon(Icons.download),
                            label: const Text('Download'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: Colors.white),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Anime Info
                      AnimeInfoSection(anime: anime),

                      const SizedBox(height: 20),

                      // Synopsis
                      SynopsisSection(synopsis: anime.synopsis),

                      const SizedBox(height: 20),

                      // Episodes
                      const Text(
                        'Episodes',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      EpisodeList(
                        episodes: anime.episodes,
                        animeTitle: anime.title,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: LoadingWidget()),
        error:
            (error, stack) => CustomErrorWidget(
              message: 'Failed to load anime details',
              onRetry: () => ref.refresh(animeDetailProvider(animeId)),
            ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'ongoing':
        return AppColors.ongoing;
      case 'completed':
        return AppColors.completed;
      case 'trending':
        return AppColors.trending;
      default:
        return AppColors.primaryBlue;
    }
  }
}
