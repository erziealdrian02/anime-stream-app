import 'anime.dart';

class Schedule {
  final String day;
  final List<Anime> animeList;

  Schedule({required this.day, required this.animeList});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      day: json['day'] ?? '',
      animeList:
          (json['anime_list'] as List?)
              ?.map((e) => Anime.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'anime_list': animeList.map((anime) => anime.toJson()).toList(),
    };
  }
}
