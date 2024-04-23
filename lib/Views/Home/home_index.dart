import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Provider/profile_provider.dart';
import 'package:crowdfunding/Views/Account/account.dart';
import 'package:crowdfunding/Views/Campaigns/my_campaign.dart';
import 'package:crowdfunding/Views/Home/dashboard.dart';
import 'package:crowdfunding/Views/Home/home_page.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeIndex extends StatefulWidget {
  final int? initialIdex;
  const HomeIndex({super.key, this.initialIdex});

  @override
  State<HomeIndex> createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _selectedIndex = widget.initialIdex ?? 0;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProfileProvider>().getUser(context);
    });
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      const HomePage(),
      const DashboardPage(),
      const MyCapmaign(),
      const AccountPage()
    ];
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 4,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: SizedBox(
              width: 23,
              height: 23,
              child: Icon(FeatherIcons.home)
            ),
            icon: SizedBox(
              width: 23,
              height: 23,
              child: Icon(FeatherIcons.home)
            ),
            label: ('Home'),
          ),
          BottomNavigationBarItem(
            activeIcon: SizedBox(
              width: 23,
              height: 23,
              child:  Icon(Icons.dashboard)
            ),
            icon: SizedBox(
              width: 23,
              height: 23,
              child: Icon(Icons.dashboard)
            ),
            label: ('Dashboard'),
          ),
          BottomNavigationBarItem(
            activeIcon: SizedBox(
              width: 23,
              height: 23,
              child:  Icon(Icons.campaign_outlined)
            ),
            icon: SizedBox(
              width: 23,
              height: 23,
              child:Icon(Icons.campaign_outlined)
            ),
            label: ('Campaigns'),
          ),
           BottomNavigationBarItem(
            activeIcon: SizedBox(
              width: 23,
              height: 23,
              child:  Icon(FeatherIcons.user)
            ),
            icon: SizedBox(
              width: 23,
              height: 23,
              child:Icon(FeatherIcons.user)
            ),
            label: ('Account'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.SECONDARYCOLOR,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
