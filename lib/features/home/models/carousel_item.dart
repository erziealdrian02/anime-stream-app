import '../../../core/models/anime.dart';

class CarouselItem {
  final String id;
  final String title;
  final String imageUrl;
  final String description;
  final String? buttonText;
  final String? buttonAction;

  CarouselItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    this.buttonText,
    this.buttonAction,
  });

  factory CarouselItem.fromAnime(Anime anime) {
    return CarouselItem(
      id: anime.id,
      title: anime.title,
      imageUrl: anime.imageUrl,
      description:
          anime.synopsis.length > 100
              ? '${anime.synopsis.substring(0, 100)}...'
              : anime.synopsis,
      buttonText: 'Watch Now',
      buttonAction: 'watch',
    );
  }

  factory CarouselItem.fromJson(Map<String, dynamic> json) {
    return CarouselItem(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      imageUrl: json['image_url'] ?? '',
      description: json['description'] ?? '',
      buttonText: json['button_text'],
      buttonAction: json['button_action'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image_url': imageUrl,
      'description': description,
      'button_text': buttonText,
      'button_action': buttonAction,
    };
  }
}
