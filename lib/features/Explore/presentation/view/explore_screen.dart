import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<String> categories = [
    "Croissant",
    "Toast",
    "Muffins",
    "Donuts",
  ];
  List<String> images = [
    "assets/Icons_logos/Croissant.png",
    "assets/Icons_logos/Toast.png",
    "assets/Icons_logos/Muffins.png",
    "assets/Icons_logos/Donuts.png",
  ];

  // Keys for each section
  final List<GlobalKey> sectionKeys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];

  // ScrollController to listen to scrolling events
  late ScrollController scrollController;
  BuildContext? tabContext;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    // bool tabChanged = false ;
    for (int i = 0; i < sectionKeys.length; i++) {
      final RenderBox? box =
          sectionKeys[i].currentContext!.findRenderObject() as RenderBox?;
      if (box != null) {
        final position = box.localToGlobal(Offset.zero);
        if (position.dy <= 300 && position.dy + box.size.height > 300) {
          DefaultTabController.of(tabContext!)?.animateTo(i);
          // tabChanged = true;
          break;
        }
      }
    }

    // if(!tabChanged)
    // {
    //   final scrollableBottom  = scrollController.position.maxScrollExtent ;
    //   if(scrollController.position.pixels >= scrollableBottom)
    //   {
    //      DefaultTabController.of(tabContext!)?.animateTo(sectionKeys.length - 1);
    //   }

    // }
  }

  void _scrollToSection(int index) {
    scrollController.removeListener(_handleScroll);
    final context = sectionKeys[index].currentContext!;
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 500),
    ).then((value) {
      scrollController.addListener(_handleScroll);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('hello from explore screen'),
      ),
    );
  }
}
