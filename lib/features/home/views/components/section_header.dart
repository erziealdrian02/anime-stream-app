import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../config/routes/route_names.dart';
import '../../../../../config/theme/app_colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final bool showViewAll;
  final String? sectionType;
  final VoidCallback? onViewAllPressed;

  const SectionHeader({
    super.key,
    required this.title,
    this.showViewAll = true,
    this.sectionType,
    this.onViewAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (showViewAll)
            GestureDetector(
              onTap:
                  onViewAllPressed ??
                  () {
                    if (sectionType != null) {
                      context.goNamed(
                        RouteNames.animeListBySection,
                        pathParameters: {'sectionType': sectionType!},
                        queryParameters: {'title': title},
                      );
                    }
                  },
              child: Row(
                children: [
                  Text(
                    'View All',
                    style: TextStyle(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: AppColors.primaryBlue,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
