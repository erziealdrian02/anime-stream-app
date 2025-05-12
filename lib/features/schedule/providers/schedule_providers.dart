import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/schedule.dart';
import '../../../core/services/api_service.dart';
import '../controllers/schedule_controller.dart';
import '../repositories/schedule_repository.dart';

// Add this if not defined elsewhere
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final scheduleRepositoryProvider = Provider<ScheduleRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return ScheduleRepository(apiService);
});

final scheduleControllerProvider =
    StateNotifierProvider<ScheduleController, AsyncValue<List<Schedule>>>((
      ref,
    ) {
      final repository = ref.watch(scheduleRepositoryProvider);
      return ScheduleController(repository);
    });

final scheduleProvider = FutureProvider<List<Schedule>>((ref) async {
  final repository = ref.watch(scheduleRepositoryProvider);
  return repository.getSchedule();
});

final daysProvider = Provider<List<String>>((ref) {
  final controller = ref.watch(scheduleControllerProvider.notifier);
  return controller.getDays();
});

final scheduleForDayProvider = Provider.family<Schedule?, String>((ref, day) {
  final controller = ref.watch(scheduleControllerProvider.notifier);
  return controller.getScheduleForDay(day);
});
