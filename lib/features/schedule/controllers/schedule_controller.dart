import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/schedule.dart';
import '../repositories/schedule_repository.dart';

class ScheduleController extends StateNotifier<AsyncValue<List<Schedule>>> {
  final ScheduleRepository _repository;

  ScheduleController(this._repository) : super(const AsyncValue.loading()) {
    loadSchedule();
  }

  ScheduleController.named(this._repository) : super(const AsyncValue.loading()) {
    loadSchedule();
  }

  Future<void> loadSchedule() async {
    try {
      state = const AsyncValue.loading();
      final schedules = await _repository.getSchedule();
      state = AsyncValue.data(schedules);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  List<String> getDays() {
    return state.when(
      data: (schedules) {
        return schedules.map((s) => s.day).toList();
      },
      loading: () => [],
      error: (_, __) => [],
    );
  }

  Schedule? getScheduleForDay(String day) {
    return state.when(
      data: (schedules) {
        try {
          return schedules.firstWhere((s) => s.day == day);
        } catch (_) {
          return null;
        }
      },
      loading: () => null,
      error: (_, __) => null,
    );
  }
}
