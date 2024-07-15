import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadget_store/config/routes/app_route.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.popAndPushNamed(context, AppRoute.loginRoute);
      // ref.read(splashViewModelProvider.notifier).init(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Cloth Store',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 10),
                CircularProgressIndicator(),
                SizedBox(height: 10),
              ],
            ),
          ),
          Positioned(
              bottom: 10,
              left: MediaQuery.of(context).size.width / 2.5,
              child: const Column(
                children: [
                  Text(
                    'Developed By',
                    style: TextStyle(color: Colors.amber, fontSize: 20),
                  ),
                  Text(
                    'Aditya Thakur',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
