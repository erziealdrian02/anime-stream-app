import './episode.dart';

class Anime {
  final String id;
  final String title;
  final String japaneseTitle;
  final String imageUrl;
  final String status;
  final double score;
  final String duration;
  final String releaseDate;
  final List<String> genres;
  final String synopsis;
  final List<Episode> episodes;

  Anime({
    required this.id,
    required this.title,
    required this.japaneseTitle,
    required this.imageUrl,
    required this.status,
    required this.score,
    required this.duration,
    required this.releaseDate,
    required this.genres,
    required this.synopsis,
    required this.episodes,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      japaneseTitle: json['japanese_title'] ?? '',
      imageUrl: json['image_url'] ?? '',
      status: json['status'] ?? '',
      score: (json['score'] ?? 0.0).toDouble(),
      duration: json['duration'] ?? '',
      releaseDate: json['release_date'] ?? '',
      genres: List<String>.from(json['genres'] ?? []),
      synopsis: json['synopsis'] ?? '',
      episodes:
          (json['episodes'] as List?)
              ?.map((e) => Episode.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'japanese_title': japaneseTitle,
      'image_url': imageUrl,
      'status': status,
      'score': score,
      'duration': duration,
      'release_date': releaseDate,
      'genres': genres,
      'synopsis': synopsis,
      'episodes': episodes.map((episode) => episode.toJson()).toList(),
    };
  }
}
