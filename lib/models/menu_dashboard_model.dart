import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cdli_tablet_app/routes/menu.dart';
import 'package:cdli_tablet_app/models/dashboard_model.dart';
import 'package:cdli_tablet_app/models/menu_model.dart';

class MenuDashboardModel extends StatefulWidget {
  @override
  _MenuDashboardModelState createState() => _MenuDashboardModelState();
}

class _MenuDashboardModelState extends State<MenuDashboardModel> with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.6).animate(_controller);
    _menuScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onMenuTap() {
    setState(() {
      if (isCollapsed)
        _controller.forward();
      else
        _controller.reverse();

      isCollapsed = !isCollapsed;
    });
  }

  void onMenuItemClicked() {
    setState(() {
      _controller.reverse();
    });

    isCollapsed = !isCollapsed;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: Color.fromRGBO(18, 18, 18, 1),
      body: BlocProvider<NavigationBloc>(
        create: (context) => NavigationBloc(onMenuTap: onMenuTap),
        child: Stack(
          children: <Widget>[
            BlocBuilder<NavigationBloc, NavigationState>(
              builder: (context, NavigationState navigationState) {
                return Menu(
                  slideAnimation: _slideAnimation,
                  menuAnimation: _menuScaleAnimation,
                  onMenuItemClicked: onMenuItemClicked
                );
              },
            ),
            DashboardModel(
              duration: duration,
              onMenuTap: onMenuTap,
              scaleAnimation: _scaleAnimation,
              isCollapsed: isCollapsed,
              screenWidth: screenWidth,
              child: BlocBuilder<NavigationBloc, NavigationState>(builder: (context,
                  NavigationState navigationState,) {
                return navigationState as Widget;
              }),
            ),
          ],
        ),
      ),
    );
  }
}
