import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/route_names.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/models/episode.dart';
import '../../../../core/utils/date_formatter.dart';

class EpisodeList extends ConsumerWidget {
  final List<Episode> episodes;
  final String animeTitle;

  const EpisodeList({
    super.key,
    required this.episodes,
    required this.animeTitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: episodes.length,
      itemBuilder: (context, index) {
        final episode = episodes[index];
        return EpisodeItem(
          episode: episode,
          animeTitle: animeTitle,
          isLast: index == episodes.length - 1,
        );
      },
    );
  }
}

class EpisodeItem extends ConsumerWidget {
  final Episode episode;
  final String animeTitle;
  final bool isLast;

  const EpisodeItem({
    super.key,
    required this.episode,
    required this.animeTitle,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        context.goNamed(
          RouteNames.videoPlayer,
          queryParameters: {
            'videoUrl': episode.url,
            'title': animeTitle,
            'episodeNumber': episode.number,
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border:
              isLast
                  ? null
                  : Border(
                    bottom: BorderSide(color: Colors.grey.shade800, width: 1),
                  ),
        ),
        child: Row(
          children: [
            // Episode Thumbnail
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    episode.thumbnailUrl.isNotEmpty
                        ? episode.thumbnailUrl
                        : 'https://via.placeholder.com/120x68',
                    width: 120,
                    height: 68,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 120,
                        height: 68,
                        color: Colors.grey.shade800,
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                if (episode.isDownloaded)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.download_done,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
              ],
            ),

            // Episode Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Episode ${episode.number}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (episode.title.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        episode.title,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      DateFormatter.formatEpisodeReleaseDate(
                        episode.releaseDate,
                      ),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Download Button
            IconButton(
              onPressed: () {
                // Show download options
                _showDownloadOptions(context, ref);
              },
              icon: Icon(
                episode.isDownloaded ? Icons.download_done : Icons.download,
                color:
                    episode.isDownloaded ? AppColors.primaryBlue : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDownloadOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Download Options',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              if (episode.isDownloaded) ...[
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text('Delete Download'),
                  onTap: () {
                    // Delete downloaded episode
                    Navigator.pop(context);
                  },
                ),
              ] else ...[
                ListTile(
                  leading: const Icon(Icons.high_quality, color: Colors.white),
                  title: const Text('High Quality'),
                  subtitle: const Text('720p - 300MB'),
                  onTap: () {
                    // Download high quality
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.sd, color: Colors.white),
                  title: const Text('Medium Quality'),
                  subtitle: const Text('480p - 150MB'),
                  onTap: () {
                    // Download medium quality
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.low_priority, color: Colors.white),
                  title: const Text('Low Quality'),
                  subtitle: const Text('360p - 80MB'),
                  onTap: () {
                    // Download low quality
                    Navigator.pop(context);
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
