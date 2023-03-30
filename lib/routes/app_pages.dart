import 'package:flutter/material.dart';
import 'package:get/get.dart';



import '../screens/dashboard/dashboard_binding.dart';
import '../screens/dashboard/dashboard_page.dart';
import '../screens/favorite/favorite_binding.dart';
import '../screens/favorite/favorite_screen.dart';
import '../screens/order_screen/order_binding.dart';
import '../screens/order_screen/view.dart';
import 'app_routes.dart';
class  AppPages{
  static var list = [
    GetPage(
        name: AppRoutes.DASHBOARD,
        page: ()=> const DashboardPage() ,
        binding:DashboardBinding ()
    ),
    GetPage(
        name: AppRoutes.HOME,
        page: ()=> const OrderScreenPage() ,
       binding:OrderScreenBinding()
    ),
    GetPage(
        name: AppRoutes.Favorite,
        page: ()=> const FavoriteScreen() ,
        binding:FavoriteScreenBinding()
    ),

  ];
}