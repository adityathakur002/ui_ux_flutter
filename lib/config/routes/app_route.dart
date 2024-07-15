import 'package:gadget_store/features/order/presentation/view/product_view.dart';
import 'package:gadget_store/view/dashboard_page.dart';

import '../../features/auth/presentation/view/login_view.dart';
import '../../features/auth/presentation/view/register_view.dart';
import '../../features/product/presentation/view/add_product.dart';
import '../../features/product/presentation/view/single_product_view.dart';
import '../../features/splash/presentation/view/splash_view.dart';

class AppRoute {
  AppRoute._();

  static const String splashRoute = '/splash';
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String addProductRoute = '/addProduct';
  static const String singleProductRoute = '/singleProduct';
  static const String orderViewRoute = '/orderall';

  static getApplicationRoute() {
    return {
      splashRoute: (context) => const SplashView(),
      loginRoute: (context) => const LoginView(),
      homeRoute: (context) => const Dashboard(),
      registerRoute: (context) => const RegisterView(),
      addProductRoute: (context) => const AddProduct(),
      singleProductRoute: (context) => const SingleProductView(),
      orderViewRoute: (context) => const ProductView(),
    };
  }
}
