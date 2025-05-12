import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../providers/download_providers.dart';
import 'components/episode_list_item.dart';

class DownloadedEpisodesPage extends ConsumerWidget {
  final String animeId;

  const DownloadedEpisodesPage({Key? key, required this.animeId})
    : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animeAsync = ref.watch(downloadedAnimeProvider);
    final episodesAsync = ref.watch(downloadedEpisodesProvider(animeId));

    return Scaffold(
      appBar: animeAsync.when(
        data: (animeList) {
          final anime = animeList.firstWhere(
            (a) => a.id == animeId,
            orElse: () => throw Exception('Anime not found'),
          );
          return CustomAppBar(title: anime.title, centerTitle: true);
        },
        loading:
            () => const CustomAppBar(title: 'Loading...', centerTitle: true),
        error:
            (_, __) => const CustomAppBar(
              title: 'Downloaded Episodes',
              centerTitle: true,
            ),
      ),
      body: episodesAsync.when(
        data: (episodes) {
          if (episodes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.video_library, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'No downloaded episodes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your downloaded episodes will appear here',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
                  ),
                ],
              ),
            );
          }

          return animeAsync.when(
            data: (animeList) {
              final anime = animeList.firstWhere(
                (a) => a.id == animeId,
                orElse: () => throw Exception('Anime not found'),
              );

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: episodes.length,
                itemBuilder: (context, index) {
                  final episode = episodes[index];
                  return EpisodeListItem(
                    episode: episode,
                    animeTitle: anime.title,
                    onDeletePressed: () {
                      // Delete downloaded episode
                      ref
                          .read(downloadControllerProvider.notifier)
                          .deleteDownloadedEpisode(animeId, episode);
                    },
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => const Center(child: Text('Error loading anime')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
