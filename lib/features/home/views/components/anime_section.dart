import 'package:flutter/material.dart';
import '../../../../core/models/anime.dart';
import '../../../../shared/widgets/anime_card.dart';
import 'section_header.dart';

class AnimeSection extends StatelessWidget {
  final String title;
  final List<Anime> animeList;
  final bool showViewAll;
  final String? sectionType;
  final VoidCallback? onViewAllPressed;
  final double cardWidth;
  final double cardHeight;
  final bool showRating;
  final bool showStatus;

  const AnimeSection({
    super.key,
    required this.title,
    required this.animeList,
    this.showViewAll = true,
    this.sectionType,
    this.onViewAllPressed,
    this.cardWidth = 140,
    this.cardHeight = 200,
    this.showRating = true,
    this.showStatus = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: title,
          showViewAll: showViewAll,
          sectionType: sectionType,
          onViewAllPressed: onViewAllPressed,
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: cardHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: animeList.length,
            itemBuilder: (context, index) {
              return AnimeCard(
                anime: animeList[index],
                width: cardWidth,
                height: cardHeight,
                showRating: showRating,
                showStatus: showStatus,
              );
            },
          ),
        ),
      ],
    );
  }
}
