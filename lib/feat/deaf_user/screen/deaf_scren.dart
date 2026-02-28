import 'package:flutter/material.dart';
import 'package:test_2/core/routes/routes.dart';
import 'package:test_2/core/widgets/home_drawer.dart';
import 'package:test_2/core/widgets/home_header.dart';
import 'package:test_2/feat/deaf_user/widgets/avatr_widget.dart';
import 'package:test_2/feat/deaf_user/widgets/bottom_widget.dart';
import 'package:test_2/feat/deaf_user/widgets/transcribed_text_widget.dart';

class DeafScreen extends StatelessWidget {
  const DeafScreen({super.key});
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const HomeDrawer(),
      body: Center(
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
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HomeHeader(title: "Deaf User"),
              AvatarWidget(),
              TranscribedTextWidget(),
              VoiceControlPanel(),
            ],
          ),
        ),
      ),
    );
  }
}
