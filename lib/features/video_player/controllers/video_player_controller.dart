import 'dart:io'; // Add this import for File class
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerNotifier extends StateNotifier<VideoPlayerController?> {
  VideoPlayerNotifier() : super(null);

  Future<void> initialize(String videoUrl) async {
    // Dispose previous controller if exists
    await state?.dispose();

    // Create new controller using networkUrl instead of deprecated network
    final controller = VideoPlayerController.networkUrl(
      Uri.parse(videoUrl),
      // You can add additional options here if needed
    );

    // Initialize and play
    await controller.initialize();
    controller.play();

    // Update state
    state = controller;
  }

  Future<void> initializeFromFile(String filePath) async {
    // Dispose previous controller if exists
    await state?.dispose();

    // Create new controller
    final controller = VideoPlayerController.file(
      File(filePath), // Now File is available from dart:io
    );

    // Initialize and play
    await controller.initialize();
    controller.play();

    // Update state
    state = controller;
  }

  void togglePlay() {
    if (state == null) return;

    if (state!.value.isPlaying) {
      state!.pause();
    } else {
      state!.play();
    }
  }

  void seekForward() {
    if (state == null) return;

    final currentPosition = state!.value.position;
    final newPosition = currentPosition + const Duration(seconds: 10);

    state!.seekTo(newPosition);
  }

  void seekBackward() {
    if (state == null) return;

    final currentPosition = state!.value.position;
    final newPosition = currentPosition - const Duration(seconds: 10);

    state!.seekTo(newPosition);
  }

  void seekTo(Duration position) {
    if (state == null) return;

    state!.seekTo(position);
  }

  @override
  void dispose() {
    state?.dispose();
    super.dispose();
  }
}
