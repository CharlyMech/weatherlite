import 'package:flutter/material.dart';

class ParallaxBackground extends StatelessWidget {
  final PageController pageController;
  final int pageCount;

  const ParallaxBackground({
    super.key,
    required this.pageController,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        double page = 0;
        if (pageController.hasClients && pageController.page != null) {
          page = pageController.page!;
        }

        final offset = page * 50; // Parallax factor

        return Transform.translate(
          offset: Offset(-offset, 0),
          child: Container(
            width: MediaQuery.of(context).size.width * (1 + pageCount * 0.1),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0A0E21),
                  Color(0xFF1A1F36),
                  Color(0xFF0D1B2A),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
