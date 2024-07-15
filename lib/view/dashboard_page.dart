import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadget_store/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:gadget_store/features/order/presentation/viewmodel/order_view_model.dart';
import 'package:gadget_store/features/product/presentation/viewmodel/product_viewmodel.dart';
import 'package:gadget_store/features/splash/presentation/viewmodel/splash_view_model.dart';
import 'package:gadget_store/view/about.dart';
import 'package:gadget_store/view/cart.dart';
import 'package:gadget_store/view/home.dart';
import 'package:gadget_store/view/profile.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  int _selectedIndex = 0;

  List<Widget> lstBottomScreen = [
    const Home(),
    const CartView(),
    const Profile(),
    const AboutUs(),
  ];
  @override
  Widget build(BuildContext context) {
    var userState = ref.watch(authViewModelProvider);
    var splashState = ref.watch(splashViewModelProvider);
    return Scaffold(
      body: lstBottomScreen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'About Us',
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 191, 133, 24),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 1) {
            ref.watch(cartViewModelProvider.notifier).getCart(
                  context,
                  userState.currentUser != null
                      ? userState.currentUser.id!
                      : splashState.user.id!,
                );
          }
          // if (index == 3) {
          //   ref.watch(cartViewModelProvider.notifier).getAllCarts();
          // }
          if (index == 0) {
            ref.watch(productViewModelProvider.notifier).getAllProducts();
          }
        },
      ),
    );
  }
}
