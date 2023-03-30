import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:like_button/like_button.dart';
import 'package:refalco_app/utils/const.dart';

import '../../services/notifi_service.dart';
import '../../utils/widget/card_shadow.dart';
import '../../utils/widget/image_cache.dart';
import '../favorite/favorite_controller.dart';
import 'details_order_screen.dart';
import 'index.dart';
import 'models/order.dart';

class OrderScreenPage extends GetView<OrderScreenController> {
  const OrderScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderScreenController>(
      init: OrderScreenController(),
      id: "order_screen",
      builder: (controller) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: secondaryColor,
          ),
          child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: secondaryColor,
              centerTitle: true,
              title: const Text(
                "Home",
                style: TextStyle(color: primaryColor),
              ),
            ),
            body: SafeArea(
              child: _buildView(),
            ),
          ),
        );
      },
    );
  }
}

Widget _buildView() {
  OrderScreenController controller = Get.find();

  return Center(
    child: FutureBuilder(
        future: controller.getOrderListFunction(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                  controller.readDataSoldAndNoTSold();
                return ListView.builder(
                    itemCount: controller.listDataCached.length,
                    itemBuilder: (context, index) {
                      Size size = MediaQuery.of(context).size;

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8.0),
                        child: CardShadow(
                            width: double.infinity,
                            height: size.width * 0.45,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    children: [
                                      Hero(
                                        tag:
                                            "${controller.listDataCached[index]['image'].toString()}  $index",
                                        child: CustomImage(
                                          width: double.infinity,
                                          height: size.width * 0.30,
                                          image: controller
                                              .listDataCached[index]['image']
                                              .toString(),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          isNetwork: true,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        left: 8.0,
                                        top: 2.0,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              controller.listDataCached[index]
                                                      ['id']
                                                  .toString(),
                                              style: subtitleStyle,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        controller.listDataCached[index]
                                                ['total']
                                            .toString(),
                                        style: titleStyle,
                                      ),
                                      Text(
                                        DateTimeFormat.format(
                                            DateTime.parse(controller
                                                .listDataCached[index]
                                                    ['createdAt']
                                                .toString()),
                                            format: 'D, M  H:i A'),
                                        style: subtitleStyle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      );
                    });
              } else {
                return ListView.builder(
                    itemCount: controller.listOrder!.data!.length,
                    itemBuilder: (context, index) {
                      var order = controller.listOrder!.data![index];
                      Size size = MediaQuery.of(context).size;

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8.0),
                        child: InkWell(
                          onTap: () async {

                            await Get.to(() => DetailsOrderScreen(
                                  address: order.address!,
                                  items: order.items,
                                  image: order.image.toString(),
                                  index: index,
                                ));
                          },
                          child: CardShadow(
                              width: double.infinity,
                              height: size.width * 0.45,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Stack(
                                      children: [
                                        Hero(
                                          tag:
                                              "${order.image.toString()}  $index",
                                          child: CustomImage(
                                            width: double.infinity,
                                            height: size.width * 0.30,
                                            image: order.image.toString(),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            isNetwork: true,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                            right: 8.0,
                                            top: 8.0,
                                            child: InkWell(
                                              onTap: () async {
                                                FavoriteController
                                                    favoriteController =
                                                    Get.find();
                                                favoriteController
                                                    .myFavoriteList
                                                    .add(order);
                                                controller.tappedIndex = index;
                                                await NotificationService()
                                                    .showNotification(
                                                        title:
                                                            'The operation was completed successfully  ',
                                                        body:
                                                            'the item added to favorite list');
                                                await favoriteController
                                                    .cacheListFunction();

                                                controller.update();
                                                favoriteController.update();
                                              },
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(6.0),
                                                  child: Icon(
                                                    Icons.favorite,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                            )),
                                        Positioned(
                                          left: 8.0,
                                          top: 2.0,
                                          child: InkWell(
                                            onTap: () {
                                              FavoriteController
                                                  favoriteController =
                                                  Get.find();
                                              favoriteController
                                                  .getListFunction();
                                            },
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  order.id.toString(),
                                                  style: subtitleStyle,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          order.total.toString(),
                                          style: titleStyle,
                                        ),
                                        Text(
                                          DateTimeFormat.format(
                                              DateTime.parse(
                                                  order.createdAt.toString()),
                                              format: 'D, M  H:i A'),
                                          style: subtitleStyle,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      );
                    });
              }
          }
        }),
  );
}
