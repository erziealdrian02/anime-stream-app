import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final double size;

  const RatingStars({super.key, required this.rating, this.size = 16});

  @override
  Widget build(BuildContext context) {
    final int fullStars = rating ~/ 2;
    final bool hasHalfStar = (rating - fullStars * 2) >= 1;
    final int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

    return Row(
      children: [
        ...List.generate(
          fullStars,
          (index) =>
              Icon(Icons.star, color: AppColors.ratingYellow, size: size),
        ),
        if (hasHalfStar)
          Icon(Icons.star_half, color: AppColors.ratingYellow, size: size),
        ...List.generate(
          emptyStars,
          (index) => Icon(
            Icons.star_border,
            color: AppColors.ratingYellow,
            size: size,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: size * 0.75,
          ),
        ),
      ],
    );
  }
}
