import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import '../controllers/video_player_controller.dart';

// Define the QualityOption class
class QualityOption {
  final String label;
  final String value;
  final String size;

  QualityOption({required this.label, required this.value, required this.size});
}

final videoPlayerControllerProvider =
    StateNotifierProvider<VideoPlayerNotifier, VideoPlayerController?>((ref) {
      return VideoPlayerNotifier();
    });

final isPlayingProvider = Provider<bool>((ref) {
  final controller = ref.watch(videoPlayerControllerProvider);
  return controller?.value.isPlaying ?? false;
});

final isBufferingProvider = Provider<bool>((ref) {
  final controller = ref.watch(videoPlayerControllerProvider);
  return controller?.value.isBuffering ?? true;
});

final videoPositionProvider = Provider<Duration>((ref) {
  final controller = ref.watch(videoPlayerControllerProvider);
  return controller?.value.position ?? Duration.zero;
});

final videoDurationProvider = Provider<Duration>((ref) {
  final controller = ref.watch(videoPlayerControllerProvider);
  return controller?.value.duration ?? Duration.zero;
});

final selectedQualityProvider = StateProvider<String>((ref) {
  return '720p';
});

final isFullScreenProvider = StateProvider<bool>((ref) {
  return false;
});

final qualityOptionsProvider = Provider<List<QualityOption>>((ref) {
  return [
    QualityOption(label: 'Auto', value: 'auto', size: 'Adaptive'),
    QualityOption(label: '1080p', value: '1080p', size: '500 MB/hr'),
    QualityOption(label: '720p', value: '720p', size: '300 MB/hr'),
    QualityOption(label: '480p', value: '480p', size: '150 MB/hr'),
    QualityOption(label: '360p', value: '360p', size: '80 MB/hr'),
  ];
});
