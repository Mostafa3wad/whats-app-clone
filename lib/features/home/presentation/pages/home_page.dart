import 'package:flutter/material.dart';
import 'package:whats_app_clone/config/themes/app_colors.dart';
import 'package:whats_app_clone/features/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:whats_app_clone/features/status/presentation/pages/status_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController _pageController;
  late final List<Widget> bottomBarPages;
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    bottomBarPages = <Widget>[
      const StatusPage(),
      const Scaffold(body: Center(child: Text('Progress'))),
      const Scaffold(body: Center(child: Text('Browse Books'))),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: bottomBarPages,
      ),
      extendBody: true,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey2, width: 0.8),
        ),
        child: BottomNavBar(
          currentIndex: _currentIndex,
          pageController: _pageController,
        ),
      ),
    );
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
