import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get.dart';

import '../../utils/const.dart';
import '../favorite/favorite_screen.dart';
import '../order_screen/view.dart';
import 'dashboard_controller.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (controller) {
          final pageController = PageController(initialPage: 0);
          SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
          EdgeInsets padding = const EdgeInsets.all(12);
          SnakeShape snakeShape = SnakeShape.circle;
          return Scaffold(
            // appBar: AppBar(  automaticallyImplyLeading: true,),
            extendBody: true,
            body: SafeArea(
              child: IndexedStack(
                index: controller.tabIndex,
                children: const [
                  OrderScreenPage(),
                  FavoriteScreen(),
                ],
              ),
            ),
            bottomNavigationBar: SnakeNavigationBar.color(
              // height: 80,
              behaviour: snakeBarStyle,
              snakeShape: snakeShape,
              elevation: 7,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              padding: const EdgeInsets.only(bottom: 10.0, right: 12, left: 12),

              ///configuration for SnakeNavigationBar.color
              snakeViewColor: secondaryColor,
              selectedItemColor:
                  snakeShape == SnakeShape.indicator ? primaryColor : null,
              unselectedItemColor: primaryColor,

              ///configuration for SnakeNavigationBar.gradient
              // snakeViewGradient: selectedGradient,
              // selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
              // unselectedItemGradient: unselectedGradient,

              showUnselectedLabels: true,
              showSelectedLabels: true,

              currentIndex: controller.tabIndex,
              onTap: (index) {
                controller.changeTabIndex(index);
                controller.update();
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border), label: 'Favorite'),
              ],
              selectedLabelStyle: const TextStyle(fontSize: 14),
              unselectedLabelStyle: const TextStyle(fontSize: 10),
            ),
          );
        });
  }
}
