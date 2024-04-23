import 'package:crowdfunding/Services/Local/shared_prefs_manager.dart';
import 'package:crowdfunding/Views/GetStarted/get_started.dart';
import 'package:crowdfunding/Views/Home/home_index.dart';
import 'package:flutter/material.dart';
import '../../Core/Helpers/navigation_helper.dart';
import '../../Utils/connection_util.dart';
import 'splash_screen.dart';

ConnectionUtil connectionStatus = ConnectionUtil.getInstance();

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  final ValueNotifier<bool> hasInterNetConnection = ValueNotifier(false);
  bool _appStarted = true;

  // final _service = AuthRemoteService();
  @override
  void initState() {
    connectionStatus.initialize();
    if (!connectionStatus.connectionChangeController.isClosed) {
      connectionStatus.connectionChange.listen(connectionChanged);
    }

    super.initState();
    _checkAuthState();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: hasInterNetConnection,
        builder: (BuildContext context, _, __) {
          return const SplashScreen();
        });
  }

  void connectionChanged(dynamic hasConnection) {
    hasInterNetConnection.value = hasConnection;

    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();

    if (!hasInterNetConnection.value) {
      _appStarted = false;
      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          padding: const EdgeInsets.all(10),
          content: const Text('Check Internet Connectivity',
              style: TextStyle(color: Colors.white)),
          leading: const Icon(Icons.info, color: Colors.white),
          backgroundColor: Colors.red,
          actions: <Widget>[
            TextButton(
              child: const Text(
                '',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                // AppNavigationHelper.navigateToWidget(
                //     context, CreateOfflineUser());
                // ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
            ),
          ],
        ),
      );
    } else {
      if (_appStarted == false) {
        ScaffoldMessenger.of(context).showMaterialBanner(
          MaterialBanner(
            padding: const EdgeInsets.all(10),
            content: const Text('Internet connected',
                style: TextStyle(color: Colors.white)),
            leading: const Icon(Icons.info, color: Colors.white),
            backgroundColor: Colors.green,
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Close',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                },
              ),
            ],
          ),
        );
        Future.delayed(const Duration(minutes: 3), () {
          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        });
      }
    }
    setState(() {});
  }

  _checkAuthState() async {
    bool isAuthenticated = await SharedPrefsManager().isAuthenticated();

    debugPrint(isAuthenticated.toString());
    if (isAuthenticated) {
      Future.delayed(const Duration(seconds: 3), () {
        AppNavigationHelper.setRootOldWidget(context, const HomeIndex());
      });

    } else {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          return AppNavigationHelper.navigateAndReplaceWidget(
              context, const GetStarted());
        },
      );
    }
  }
}
