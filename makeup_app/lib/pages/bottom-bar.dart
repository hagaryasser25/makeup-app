import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:makeup_app/pages/all-products.dart';
import 'package:makeup_app/pages/home.dart';

class BottomBar extends StatefulWidget {
  static const routeName = '/bottomBar';
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final _pageController = PageController(initialPage: 0);
  int maxCount = 4;

  final List<Widget> bottomBarPages = [
    Home(),
    AllProducts(),
    Home(),
    Home(),

  ];

  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              pageController: _pageController,
              color: Color.fromARGB(255, 34, 34, 34),
              showLabel: false,
              notchColor: HexColor('#ff3660'),
              bottomBarItems: [
                 BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home ,
                    color: HexColor('#ff3660'),
                  ),
                  activeItem: Icon(
                    Icons.home ,
                    color: Colors.white,
                  ),
                  itemLabel: 'Page 1',
                ),
                 BottomBarItem(
                  inActiveItem: Icon(
                    Icons.article  ,
                    color: HexColor('#ff3660'),
                  ),
                  activeItem: Icon(
                    Icons.article  ,
                    color: Colors.white,
                  ),
                  itemLabel: 'Page 2',
                ),
                 BottomBarItem(
                  inActiveItem: Icon(
                    Icons.shopping_cart,
                    color: HexColor('#ff3660'),
                  ),
                  activeItem: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  itemLabel: 'Page 2',
                ),

                ///svg example
                BottomBarItem(
                   inActiveItem: Icon(
                    Icons.person,
                    color: HexColor('#ff3660'),
                  ),
                  activeItem: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  itemLabel: 'Page 3',
                ),

              ],
              onTap: (index) {
                /// control your animation using page controller
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              },
            )
          : null,
    );
  }
}