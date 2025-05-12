import 'dart:async'; // Add this import for Timer
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../config/theme/app_colors.dart';
import 'quality_selector.dart';

class PlayerControls extends StatefulWidget {
  final bool isPlaying;
  final bool isBuffering;
  final Duration position;
  final Duration duration;
  final String title;
  final String episodeNumber;
  final VoidCallback onPlayPause;
  final VoidCallback onForward;
  final VoidCallback onRewind;
  final Function(Duration) onSeek;
  final VoidCallback onBack;
  final VoidCallback onFullScreenToggle;
  final bool isFullScreen;
  final List<QualityOption> qualityOptions;
  final String selectedQuality;
  final Function(String) onQualitySelected;

  const PlayerControls({
    super.key,
    required this.isPlaying,
    required this.isBuffering,
    required this.position,
    required this.duration,
    required this.title,
    required this.episodeNumber,
    required this.onPlayPause,
    required this.onForward,
    required this.onRewind,
    required this.onSeek,
    required this.onBack,
    required this.onFullScreenToggle,
    required this.isFullScreen,
    required this.qualityOptions,
    required this.selectedQuality,
    required this.onQualitySelected,
  });

  @override
  State<PlayerControls> createState() => _PlayerControlsState();
}

class _PlayerControlsState extends State<PlayerControls> {
  bool _showControls = true;
  bool _showQualitySelector = false;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();
    _startHideTimer();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && _showControls && widget.isPlaying) {
        setState(() {
          _showControls = false;
          _showQualitySelector = false;
        });
      }
    });
  }

  void _handleTap() {
    setState(() {
      _showControls = !_showControls;
      _showQualitySelector = false;
    });

    if (_showControls) {
      _startHideTimer();
    }
  }

  void _toggleQualitySelector() {
    setState(() {
      _showQualitySelector = !_showQualitySelector;
    });
    _startHideTimer();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return duration.inHours > 0
        ? '$hours:$minutes:$seconds'
        : '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        color: Colors.transparent,
        child: Stack(
          children: [
            // Background gradient when controls are visible
            if (_showControls)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withAlpha(178), // 0.7 opacity
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black.withAlpha(178), // 0.7 opacity
                      ],
                      stops: const [0.0, 0.3, 0.7, 1.0],
                    ),
                  ),
                ),
              ),

            // Top bar with title and back button
            if (_showControls)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: widget.onBack,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Episode ${widget.episodeNumber}',
                              style: TextStyle(
                                color: Colors.grey[300],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Center play/pause button
            if (_showControls)
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 40,
                      icon: const Icon(Icons.replay_10, color: Colors.white),
                      onPressed: widget.onRewind,
                    ),
                    const SizedBox(width: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.alphaBlend(
                          AppColors.primaryBlue.withAlpha(204), // 0.8 opacity
                          Colors.transparent,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        iconSize: 50,
                        icon: Icon(
                          widget.isBuffering
                              ? Icons.hourglass_empty
                              : (widget.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow),
                          color: Colors.white,
                        ),
                        onPressed:
                            widget.isBuffering ? null : widget.onPlayPause,
                      ),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      iconSize: 40,
                      icon: const Icon(Icons.forward_10, color: Colors.white),
                      onPressed: widget.onForward,
                    ),
                  ],
                ),
              ),

            // Bottom controls with progress bar
            if (_showControls)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    // Progress bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Text(
                            _formatDuration(widget.position),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          Expanded(
                            child: SliderTheme(
                              data: SliderThemeData(
                                trackHeight: 2,
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 6,
                                ),
                                overlayShape: const RoundSliderOverlayShape(
                                  overlayRadius: 12,
                                ),
                                activeTrackColor: AppColors.primaryBlue,
                                inactiveTrackColor: Colors.grey[700]!,
                                thumbColor: AppColors.primaryBlue,
                                overlayColor: Color.alphaBlend(
                                  AppColors.primaryBlue.withAlpha(
                                    76,
                                  ), // 0.3 opacity
                                  Colors.transparent,
                                ),
                              ),
                              child: Slider(
                                value:
                                    widget.position.inMilliseconds.toDouble(),
                                min: 0,
                                max: widget.duration.inMilliseconds.toDouble(),
                                onChanged: (value) {
                                  widget.onSeek(
                                    Duration(milliseconds: value.toInt()),
                                  );
                                },
                              ),
                            ),
                          ),
                          Text(
                            _formatDuration(widget.duration),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Bottom buttons
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 16,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                            onPressed: _toggleQualitySelector,
                          ),
                          const Spacer(),
                          IconButton(
                            icon: Icon(
                              widget.isFullScreen
                                  ? Icons.fullscreen_exit
                                  : Icons.fullscreen,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              widget.onFullScreenToggle();
                              if (widget.isFullScreen) {
                                SystemChrome.setPreferredOrientations([
                                  DeviceOrientation.portraitUp,
                                ]);
                              } else {
                                SystemChrome.setPreferredOrientations([
                                  DeviceOrientation.landscapeLeft,
                                  DeviceOrientation.landscapeRight,
                                ]);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            // Quality selector
            if (_showControls && _showQualitySelector)
              Positioned(
                bottom: 70,
                left: 16,
                child: QualitySelector(
                  options: widget.qualityOptions,
                  selectedQuality: widget.selectedQuality,
                  onQualitySelected: (quality) {
                    widget.onQualitySelected(quality);
                    setState(() {
                      _showQualitySelector = false;
                    });
                    _startHideTimer();
                  },
                ),
              ),

            // Buffering indicator
            if (widget.isBuffering)
              const Center(
                child: CircularProgressIndicator(color: AppColors.primaryBlue),
              ),
          ],
        ),
      ),
    );
  }
}
