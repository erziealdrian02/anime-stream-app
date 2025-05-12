import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/models/anime.dart';
import '../../../../core/utils/date_formatter.dart';

class AnimeInfoSection extends StatelessWidget {
  final Anime anime;

  const AnimeInfoSection({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildInfoRow('Status', anime.status),
          _buildInfoRow('Score', anime.score.toString()),
          _buildInfoRow('Duration', anime.duration),
          _buildInfoRow(
            'Release Date',
            DateFormatter.formatReleaseDate(anime.releaseDate),
          ),
          _buildInfoRow('Genres', anime.genres.join(', ')),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
