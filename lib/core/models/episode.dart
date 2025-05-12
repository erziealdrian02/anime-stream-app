class Episode {
  final String id;
  final String title;
  final String number;
  final String url;
  final String thumbnailUrl;
  final String releaseDate;
  final bool isDownloaded;
  final String? downloadPath;

  Episode({
    required this.id,
    required this.title,
    required this.number,
    required this.url,
    required this.thumbnailUrl,
    required this.releaseDate,
    this.isDownloaded = false,
    this.downloadPath,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      number: json['number'] ?? '',
      url: json['url'] ?? '',
      thumbnailUrl: json['thumbnail_url'] ?? '',
      releaseDate: json['release_date'] ?? '',
      isDownloaded: json['is_downloaded'] ?? false,
      downloadPath: json['download_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'number': number,
      'url': url,
      'thumbnail_url': thumbnailUrl,
      'release_date': releaseDate,
      'is_downloaded': isDownloaded,
      'download_path': downloadPath,
    };
  }

  Episode copyWith({
    String? id,
    String? title,
    String? number,
    String? url,
    String? thumbnailUrl,
    String? releaseDate,
    bool? isDownloaded,
    String? downloadPath,
  }) {
    return Episode(
      id: id ?? this.id,
      title: title ?? this.title,
      number: number ?? this.number,
      url: url ?? this.url,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      releaseDate: releaseDate ?? this.releaseDate,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      downloadPath: downloadPath ?? this.downloadPath,
    );
  }
}
