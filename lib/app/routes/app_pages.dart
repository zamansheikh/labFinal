import 'package:get/get.dart';

import '../modules/crud/bindings/crud_binding.dart';
import '../modules/crud/views/crud_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.CRUD;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CRUD,
      page: () => const CrudView(),
      binding: CrudBinding(),
    ),
  ];
}
