import 'package:get/get.dart';

import 'controller.dart';

class OrderScreenBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut<OrderScreenController>(() => OrderScreenController());
  }

}