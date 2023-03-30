import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refalco_app/utils/const.dart';
import '../../utils/widget/card_shadow.dart';
import '../../utils/widget/card_shadow_no_image.dart';
import '../../utils/widget/image_cache.dart';
import '../../utils/widget/map_widget.dart';
import '../dashboard/dashboard_page.dart';
import 'models/order.dart';

class DetailsOrderScreen extends StatelessWidget {
  final String image;
  final int index;
  final Address address;
  final List<Items>? items;
  const DetailsOrderScreen(
      {Key? key,
      required this.image,
      required this.index,
      required this.items,
      required this.address})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Hero(
              tag: "${image.toString()}  $index",
              child: CustomImage(
                width: double.infinity,
                height: size.width * 0.6,
                image: image.toString(),
                borderRadius: BorderRadius.circular(8),
                isNetwork: true,
                fit: BoxFit.cover,
              )),
          SizedBox(
            width: double.infinity,
            height: 175,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: items!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: InkWell(
                      onTap: (){
                        Get.to(()=>DashboardPage());
                      },
                      child: CardShadowNoImage(
                        height: 175,
                        width: 175,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Wrap(
                                children: [
                                  Text(
                                    'name : ',
                                    style: subtitleStylePrimaryColor,
                                  ),
                                  Text(
                                    items![index].name.toString(),
                                    style: titleStyle,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0,),
                              Row(
                                children: [
                                  Text(
                                    'price : ',
                                    style: subtitleStylePrimaryColor,
                                  ),
                                  Text(
                                    "${items![index].price.toString()} \$",
                                    style: subtitleStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CardShadow(
                width: double.infinity,

                height: 300,
                child: Container(
                  decoration:const BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: MapWidget(
                    lat: double.parse(address.lat.toString()),
                    lng: double.parse(address.lng.toString()),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
