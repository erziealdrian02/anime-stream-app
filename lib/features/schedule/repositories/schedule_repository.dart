import '../../../core/models/schedule.dart';
import '../../../core/services/api_service.dart';

class ScheduleRepository {
  final ApiService _apiService;

  ScheduleRepository(this._apiService);

  Future<List<Schedule>> getSchedule() async {
    return _apiService.getSchedule();
  }
}
