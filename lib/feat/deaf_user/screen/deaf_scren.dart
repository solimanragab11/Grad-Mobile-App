import 'package:flutter/material.dart';
import 'package:test_2/core/routes/routes.dart';
import 'package:test_2/core/widgets/home_drawer.dart';
import 'package:test_2/core/widgets/home_header.dart';
import 'package:test_2/feat/deaf_user/widgets/avatr_widget.dart';
import 'package:test_2/feat/deaf_user/widgets/bottom_widget.dart';
import 'package:test_2/feat/deaf_user/widgets/transcribed_text_widget.dart';
import 'package:video_player/video_player.dart';

class DeafScreen extends StatefulWidget {
  const DeafScreen({super.key});

  @override
  State<DeafScreen> createState() => _DeafScreenState();
}

class _DeafScreenState extends State<DeafScreen> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  final TextEditingController _typedController = TextEditingController();

  VideoPlayerController? _videoController;
  double _speed = 1.0;

  final Map<String, String> signVideoMap = const {
    "hello": "assets/videos/hello.mp4",
    "birds": "assets/videos/bird.mp4",
    "bird": "assets/videos/bird.mp4",
  };

  // ✅ NEW: sequence playback queue
  List<String> _queue = [];
  int _queueIndex = 0;

  // ✅ NEW: small threshold so "end of video" detection is stable
  static const Duration _endThreshold = Duration(milliseconds: 200);

  Future<void> runMapping(String text) async {
    final words = text
        .toLowerCase()
        .trim()
        .split(RegExp(r"\s+"))
        .where((w) => w.isNotEmpty)
        .toList();

    final matches = words
        .where((w) => signVideoMap.containsKey(w))
        .map((w) => signVideoMap[w]!)
        .toList();

    // If nothing matched -> remove video & clear queue
    if (matches.isEmpty) {
      _queue = [];
      _queueIndex = 0;
      await _disposeController();
      if (mounted) setState(() {});
      return;
    }

    // ✅ Set new queue and start from first
    _queue = matches;
    _queueIndex = 0;

    await _playQueueIndex(_queueIndex);
  }

  Future<void> _playQueueIndex(int index) async {
    if (index < 0 || index >= _queue.length) return;

    final path = _queue[index];

    await _disposeController();

    final controller = VideoPlayerController.asset(path);
    _videoController = controller;

    await controller.initialize();

    // IMPORTANT: for sequential playback, looping must be false
    await controller.setLooping(false);

    await controller.setPlaybackSpeed(_speed);

    // Listen for end → play next
    controller.addListener(_onVideoTick);

    await controller.play();

    if (mounted) setState(() {});
  }

  void _onVideoTick() {
    final c = _videoController;
    if (c == null) return;
    if (!c.value.isInitialized) return;

    final pos = c.value.position;
    final dur = c.value.duration;

    // Sometimes duration can be zero early; guard it
    if (dur == Duration.zero) return;

    final atEnd = pos >= (dur - _endThreshold);

    if (atEnd) {
      // Remove listener to avoid multiple triggers
      c.removeListener(_onVideoTick);

      // Advance to next video
      _queueIndex += 1;

      if (_queueIndex < _queue.length) {
        // Play next
        _playQueueIndex(_queueIndex);
      } else {
        // Finished sequence
        if (mounted) setState(() {});
      }
    }
  }

  Future<void> _disposeController() async {
    final c = _videoController;
    if (c != null) {
      c.removeListener(_onVideoTick);
      await c.dispose();
    }
    _videoController = null;
  }

  Future<void> togglePauseResume() async {
    final c = _videoController;
    if (c == null || !c.value.isInitialized) return;

    if (c.value.isPlaying) {
      await c.pause();
    } else {
      await c.play();
    }
    if (mounted) setState(() {});
  }

  Future<void> replay() async {
    final c = _videoController;
    if (c == null || !c.value.isInitialized) return;

    // Replay CURRENT video in the sequence
    await c.seekTo(Duration.zero);
    await c.play();
    if (mounted) setState(() {});
  }

  void openSpeedPicker() {
    const speeds = [0.5, 1.0, 1.5, 2.0];

    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: speeds.map((s) {
            return ListTile(
              title: Text("${s}x"),
              trailing: (_speed == s) ? const Icon(Icons.check) : null,
              onTap: () async {
                Navigator.pop(context);
                await setSpeed(s);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<void> setSpeed(double newSpeed) async {
    _speed = newSpeed;
    final c = _videoController;
    if (c != null && c.value.isInitialized) {
      await c.setPlaybackSpeed(_speed);
    }
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _typedController.dispose();
    _disposeController(); // safe dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPlaying = _videoController?.value.isPlaying ?? false;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const HomeDrawer(),
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity != null &&
                  details.primaryVelocity! > 0) {
                _scaffoldKey.currentState?.openDrawer();
              }
            },
            onVerticalDragEnd: (details) {
              if (details.primaryVelocity != null) {
                Navigator.pushReplacementNamed(context, Routes.normalScreen);
              }
            },
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const HomeHeader(title: "Deaf User"),

                  Expanded(
                    child: AvatarWidget(controller: _videoController),
                  ),

                  TranscribedTextWidget(
                    controller: _typedController,
                    onTextChanged: runMapping,
                  ),

                  SizedBox(
                    height: 90,
                    child: VoiceControlPanel(
                      speedLabel: "${_speed}x",
                      isPlaying: isPlaying,
                      onSpeedTap: openSpeedPicker,
                      onPauseTap: togglePauseResume,
                      onMicTap: () {},    // leave for now
                      onReplayTap: replay,
                      onShareTap: () {},  // leave for now
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}