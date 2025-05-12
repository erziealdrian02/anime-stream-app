import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../providers/download_providers.dart';
import 'components/download_anime_card.dart';

class DownloadPage extends ConsumerWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadedAnimeAsync = ref.watch(downloadedAnimeProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Downloads', centerTitle: true),
      body: downloadedAnimeAsync.when(
        data: (animeList) {
          if (animeList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.download_done, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'No downloaded anime',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your downloaded anime will appear here',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: animeList.length,
            itemBuilder: (context, index) {
              final anime = animeList[index];
              return DownloadAnimeCard(
                anime: anime,
                onTap: () {
                  // Navigate to downloaded episodes page
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
