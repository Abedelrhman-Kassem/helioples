import 'package:flutter/material.dart';

class HelioplisLogo extends StatelessWidget {
  const HelioplisLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.14 * MediaQuery.sizeOf(context).height,
      width: 0.14 * MediaQuery.sizeOf(context).height,
      child: const Image(
          image: AssetImage("assets/Icons_logos/Helioplis_logo.png")),
    );
  }
}
