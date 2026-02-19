import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/topic_manager.dart';
import 'package:negmt_heliopolis/features/Intro/presentation/view/widgets/animated_bottom_content.dart';
import 'package:negmt_heliopolis/features/Intro/presentation/view/widgets/animated_intro_logo.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      TopicManager.requestPermission();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/screens_background/intro-background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: const SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [AnimatedIntroLogo(), AnimatedBottomContent()],
          ),
        ),
      ),
    );
  }
}
