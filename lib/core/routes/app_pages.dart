import 'package:country_list_app/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../../views/home/home_page.dart';
import '../../views/login/login_page.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.login, page: () => LoginPage()),
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeController>(() => HomeController());
      }),
    ),
  ];
}
