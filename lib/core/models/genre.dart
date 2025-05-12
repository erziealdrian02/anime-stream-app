class Genre {
  final String id;
  final String name;
  final String imageUrl;
  final int animeCount;

  Genre({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.animeCount,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['image_url'] ?? '',
      animeCount: json['anime_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'anime_count': animeCount,
    };
  }
}
