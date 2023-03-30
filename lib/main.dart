import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refalco_app/screens/dashboard/dashboard_binding.dart';
import 'package:refalco_app/services/notifi_service.dart';

import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'screens/dashboard/dashboard_page.dart';
import 'screens/order_screen/view.dart';
import 'screens/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'refalco',

      initialBinding: DashboardBinding(),
      initialRoute: AppRoutes.DASHBOARD,


      getPages: AppPages.list,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

    );
  }
}
