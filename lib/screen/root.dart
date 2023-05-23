import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/screen/home/home.dart';
import 'package:nike_store/widgets/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'auth/auth.dart';

const int homeIndex = 0;
const int cartIndex = 1;
const int profileIndex = 2;
const int themeindex = 3;

class RootScreen extends StatefulWidget {
  final GestureTapCallback onTap;
  const RootScreen({
    super.key,
    required this.onTap,
  });
  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int selectedScreenIndex = homeIndex;
  final List<int> _history = [];

  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _cartKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    homeIndex: _homeKey,
    cartIndex: _cartKey,
    profileIndex: _profileKey,
  };

  Future<bool> _onWillPop() async {
    final NavigatorState currentSelectedTabNavigatorState =
        map[selectedScreenIndex]!.currentState!;
    if (currentSelectedTabNavigatorState.canPop()) {
      currentSelectedTabNavigatorState.pop();
      return false;
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedScreenIndex = _history.last;
        _history.removeLast();
      });
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: IndexedStack(
            index: selectedScreenIndex,
            children: [
              _navigator(_homeKey, homeIndex, HomeScreen()),
              _navigator(
                  _cartKey,
                  cartIndex,
                  const Center(
                    child: Text('Cart'),
                  )),
              _navigator(
                  _profileKey,
                  profileIndex,
                  Center(
                    child: AuthScreen(),
                  )),
            ],
          ),
          bottomNavigationBar: Row(
            children: [
              Expanded(
                child: BottomNavigationBar(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  selectedItemColor: Theme.of(context).colorScheme.primary,
                  unselectedItemColor:
                      Theme.of(context).colorScheme.onBackground,
                  // fixedColor: Theme.of(context).colorScheme.onSecondary,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.home), label: 'خانه'),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.cart), label: 'سبد خرید'),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.person), label: 'پروفایل'),
                    // BottomNavigationBarItem(
                    //     icon: Icon(CupertinoIcons.sun_max), label: 'تم' ,),
                  ],
                  currentIndex: selectedScreenIndex,
                  onTap: (selectedIndex) {
                    setState(() {
                      _history.remove(selectedScreenIndex);
                      _history.add(selectedScreenIndex);
                      selectedScreenIndex = selectedIndex;
                    });
                  },
                ),
              ),
              IconButton(
                onPressed: widget.onTap,
                icon: const Icon(CupertinoIcons.sun_max),
              )
            ],
          ),
        ));
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedScreenIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => Offstage(
                    offstage: selectedScreenIndex != index, child: child)));
  }
}
