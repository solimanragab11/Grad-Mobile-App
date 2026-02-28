import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AvatarWidget extends StatelessWidget {
  final VideoPlayerController? controller;

  const AvatarWidget({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      clipBehavior: Clip.antiAlias,
      child: controller == null
          ? const Center(
              child: Icon(
                Icons.person,
                size: 200,
                color: Colors.blueGrey,
              ),
            )
          : _VideoBox(controller: controller!),
    );
  }
}

class _VideoBox extends StatelessWidget {
  final VideoPlayerController controller;

  const _VideoBox({required this.controller});

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(
        width: controller.value.size.width,
        height: controller.value.size.height,
        child: VideoPlayer(controller),
      ),
    );
  }
}