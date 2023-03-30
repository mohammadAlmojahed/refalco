import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:soundpool/soundpool.dart';

import '../../utils/const.dart';
import '../../utils/widget/card_shadow.dart';
import '../../utils/widget/image_cache.dart';
import '../order_screen/details_order_screen.dart';
import '../order_screen/models/order.dart';
import 'favorite_controller.dart';

class FavoriteScreen extends GetView<FavoriteController> {
  const FavoriteScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Soundpool? pool;
    pool = Soundpool(streamType: StreamType.notification);
    return  AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: secondaryColor,
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: secondaryColor,
          centerTitle: true ,
          title: const Text(
            "Favorite",
            style: TextStyle(color: primaryColor),
          ),
        ),
        body: GetBuilder<FavoriteController>(
            init: FavoriteController(),
            builder: (controller) {
              return ListView.builder(
                  itemCount: controller.myFavoriteList.length,
                  itemBuilder: (context, index) {
                    Size size = MediaQuery.of(context).size;
                    Data order = controller.myFavoriteList[index];
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    children: [
                                      Hero(
                                        tag: "${order.image.toString()}  $index",
                                        child: CustomImage(
                                          width: double.infinity,
                                          height: size.width * 0.30,
                                          image: order.image.toString(),
                                          borderRadius: BorderRadius.circular(8),
                                          isNetwork: true,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                          right: 8.0,
                                          top: 2.0,
                                          child: InkWell(
                                            onTap: () async {
                                              int soundId = await rootBundle
                                                  .load("assets/sound.wav")
                                                  .then((ByteData soundData) {
                                                return pool!.load(soundData);
                                              });
                                              await pool!.play(soundId);
                                              controller.myFavoriteList
                                                  .removeAt(index);
                                              controller.update();
                                            },
                                            child: Container(
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(6.0),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.delete,
                                                      size: 18,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                )),
                                          )),
                                      Positioned(
                                        left: 8.0,
                                        top: 2.0,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              order.id.toString(),
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
            }),
      ),
    );
  }
}
