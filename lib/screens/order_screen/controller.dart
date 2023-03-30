import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../services/data_base.dart';
import '../../utils/const.dart';
import 'models/order.dart';

class OrderScreenController extends GetxController {
  OrderScreenController();
  Order? listOrder;
  bool isFavorite = false;
  SqlDb sqlDb = SqlDb();
  int tappedIndex = 0;
  List<Map> listDataCached = [];

  Map<String, dynamic>? orderCache;
  GetStorage box = GetStorage();

  // @override
  // void onReady() {
  //   super.onReady();
  //   sqlDb.intialDb();
  // }

  Future<Object?> getOrderListFunction() async {
    var response = await http.get(Uri.parse(
      "$baseURL/api/v1/orders",
    ));
    if (response.statusCode == 200) {
      await sqlDb.deleteData("DELETE   FROM   'order'   ");
      listOrder = Order.fromJson(jsonDecode(response.body));
      for (var i in listOrder!.data!) {
        await sqlDb.insertData('''
                                INSERT INTO 'order'
                                (id , total , createdAt , image , currency )
                                VALUES ( "${i.id}"  ,  "${i.total}" ,  "${i.createdAt}"  , "${i.image}"  , "${i.currency}"  )
                                ''');
      }

      update();
      return listOrder;
    }
    return null;
  }

  Future<List<Map>> readDataSoldAndNoTSold() async {
    listDataCached = await sqlDb.readData("SELECT * FROM 'order' ");
    print('data red');
    update();
    return listDataCached;
  }
}
