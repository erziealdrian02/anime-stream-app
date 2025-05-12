import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/routes/route_names.dart';
import '../../config/theme/app_colors.dart';
import '../../core/models/anime.dart';
import '../../shared/widgets/rating_stars.dart';

class AnimeCard extends StatelessWidget {
  final Anime anime;
  final double width;
  final double height;
  final bool showRating;
  final bool showStatus;

  const AnimeCard({
    super.key,
    required this.anime,
    this.width = 140,
    this.height = 200,
    this.showRating = true,
    this.showStatus = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.goNamed(
          RouteNames.animeDetail,
          pathParameters: {'id': anime.id},
        );
      },
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Anime Image
            Hero(
              tag: 'anime_image_${anime.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  anime.imageUrl,
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: width,
                      height: height,
                      color: Colors.grey.shade800,
                      child: const Icon(
                        Icons.broken_image,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ),

            // Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                    stops: const [0.6, 1.0],
                  ),
                ),
              ),
            ),

            // Status Badge
            if (showStatus && anime.status.isNotEmpty)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
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
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            // Title and Rating
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    anime.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (showRating) ...[
                    const SizedBox(height: 4),
                    RatingStars(rating: anime.score, size: 12),
                  ],
                ],
              ),
            ),
          ],
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
