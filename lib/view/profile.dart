import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/auth/presentation/viewmodel/auth_view_model.dart';
import '../features/home/presentation/viewmodel/home_view_model.dart';
import '../features/splash/presentation/viewmodel/splash_view_model.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  final _gap = const SizedBox(
    height: 10,
  );

  double _proximityValue = 0;

  final List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();

    _streamSubscriptions.add(proximityEvents!.listen((ProximityEvent event) {
      setState(() {
        _proximityValue = event.proximity;
      });
    }));
  }

  final GlobalKey _logoutKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;

    var userState = ref.watch(authViewModelProvider);

    var splashState = ref.read(splashViewModelProvider);

//     bool shouldTapButtonAutomatically = _proximityValue >= 4;

//     if (shouldTapButtonAutomatically) {
// // Automatic tap when the condition is met
//       Future.delayed(const Duration(milliseconds: 200), () {
//         final dynamic button = _logoutKey.currentWidget;
//         button.onPressed(); // Simulate tap on the button
//       });
// // setState(() {
// // shouldTapButtonAutomatically = false;
// // });
//     }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard View'),
        backgroundColor: const Color.fromARGB(255, 191, 133, 24),
        actions: [
          IconButton(
            key: _logoutKey,
            onPressed: () {
              ref.read(homeViewModelProvider.notifier).logout(context);
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _gap,
          Container(
            alignment: Alignment.center,
            // child: Text(userState.currentUser!.fname),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(
                      'https://scontent.fktm8-1.fna.fbcdn.net/v/t39.30808-6/420195056_359522543493814_94498619982674295_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=efb6e6&_nc_ohc=J_-kBTkc57oAX_rt72N&_nc_ht=scontent.fktm8-1.fna&oh=00_AfCdu5fB6uXkN4odu8m7RJfEu01hRsb2JHYO6NsQC2GrGg&oe=65E71558'),
                ),
                Text(
                  userState.currentUser.username,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Text(
                //   '${userState.currentUser.fname} ${userState.currentUser.lname}',
                //   style: const TextStyle(
                //       color: Colors.black,
                //       fontSize: 21,
                //       fontStyle: FontStyle.italic),
                // ),
                _gap,
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 237, 217, 35),
                    ),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey,
              ),
              child: const Icon(Icons.call),
            ),
            title: Text(
              userState.currentUser.phone,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 21,
              ),
            ),
          ),
          ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey,
              ),
              child: const Icon(Icons.person),
            ),
            title: Text(
              '${userState.currentUser.fname} ${userState.currentUser.lname}',
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 21,
              ),
            ),
          ),
          ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey,
              ),
              child: const Icon(Icons.logout),
            ),
            title: TextButton(
                onPressed: () {
                  ref.read(homeViewModelProvider.notifier).logout(context);
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red, fontSize: 18),
                )),
          ),
        ],
      ),
    );
  }
}
