import 'package:get/get.dart';

import '../favorite/favorite_controller.dart';
import '../order_screen/controller.dart';



class DashboardBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut<FavoriteController>(() => FavoriteController());
    Get.lazyPut<OrderScreenController>(() => OrderScreenController());

  }

}