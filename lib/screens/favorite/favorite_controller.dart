import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart' as storage;
import 'package:refalco_app/screens/order_screen/models/order.dart';

import '../../utils/const.dart';

class FavoriteController extends GetxController {
  List<Data> myFavoriteList = [];
  List<dynamic> myFavoriteListCached = [];


  storage.GetStorage box = storage.GetStorage();




  Future<void> cacheListFunction() async {
    await box.write(favoriteList, jsonEncode(myFavoriteList));
    print ('done');
  }
  Future<void> getListFunction() async {
   String redFile =   await box.read(favoriteList, );
   myFavoriteListCached = jsonDecode(redFile) ;


  }
}
