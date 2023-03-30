import 'package:get/get.dart';
import 'favorite_controller.dart';
class FavoriteScreenBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut<FavoriteController>(() => FavoriteController());
  }

}