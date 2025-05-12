import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/routes/route_names.dart';
import '../../../config/theme/app_colors.dart';
import '../../../shared/widgets/error_widget.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../providers/schedule_providers.dart';
import 'components/day_selector.dart';
import 'components/schedule_item.dart';

final selectedDayProvider = StateProvider<String>((ref) {
  // Default to current day of week
  final now = DateTime.now();
  final days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  return days[now.weekday - 1]; // weekday is 1-7 for Monday-Sunday
});

class SchedulePage extends ConsumerWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleData = ref.watch(scheduleProvider);
    final selectedDay = ref.watch(selectedDayProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Anime Schedule')),
      body: Column(
        children: [
          // Day Selector
          scheduleData.when(
            data: (schedules) {
              final days = schedules.map((s) => s.day).toList();
              return DaySelector(
                days: days,
                selectedDay: selectedDay,
                onDaySelected: (day) {
                  ref.read(selectedDayProvider.notifier).state = day;
                },
              );
            },
            loading:
                () => const SizedBox(
                  height: 60,
                  child: Center(child: LoadingWidget()),
                ),
            error: (_, __) => const SizedBox(height: 60),
          ),

          // Schedule List
          Expanded(
            child: scheduleData.when(
              data: (schedules) {
                // Find the schedule for the selected day
                final daySchedule = schedules.firstWhere(
                  (s) => s.day == selectedDay,
                  orElse: () => schedules.first,
                );

                if (daySchedule.animeList.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.event_busy,
                          size: 64,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No anime scheduled for ${daySchedule.day}',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: daySchedule.animeList.length,
                  itemBuilder: (context, index) {
                    final anime = daySchedule.animeList[index];
                    return ScheduleItem(
                      anime: anime,
                      onTap: () {
                        context.goNamed(
                          RouteNames.animeDetail,
                          pathParameters: {'animeId': anime.id},
                        );
                      },
                    );
                  },
                );
              },
              loading: () => const Center(child: LoadingWidget()),
              error:
                  (error, stack) => CustomErrorWidget(
                    message: 'Failed to load schedule',
                    onRetry: () => ref.refresh(scheduleProvider),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
