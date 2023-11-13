import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:openweather_app/constants/route_paths.dart';

class AppBottomNavigationBar extends ConsumerWidget {
  final StatefulNavigationShell shell;
  const AppBottomNavigationBar({super.key, required this.shell});
 
  @override
  Widget build(BuildContext context, ref) {
    final List<StatefulShellBranch> branches = shell.route.branches;

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(height: 0),
          BottomNavigationBar(
            currentIndex: shell.currentIndex.clamp(0, branches.length),
            selectedFontSize: 0,
            unselectedFontSize: 0,
            iconSize: 30,
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              final data = getNavigationRouteDetail(branches[value].initialLocation!);

              shell.goBranch(
                data.index,
                initialLocation: data.index == shell.currentIndex,
              );
            },
            items: branches.map(
              (branch) {
                final path = branch.initialLocation!;
                final data = getNavigationRouteDetail(path);

                return BottomNavigationBarItem(
                  icon: Icon(data.iconData, color: Theme.of(context).unselectedWidgetColor),
                  activeIcon: Icon(data.iconData, color: Theme.of(context).primaryColor),
                  label: data.name,
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  ({String name, IconData iconData, int index}) getNavigationRouteDetail(String path) {
    final route = AppRoutes.values.firstWhere((route) => path == route.path);

    final history = (
      name: "History",
      iconData: CupertinoIcons.list_bullet,
      index: route.index,
    );
    final home = (
      name: "Home",
      iconData: CupertinoIcons.home,
      index: route.index,
    );

    final data = switch (route) {
      AppRoutes.history => history,
      _ => home,
    };

    return data;
  }
}
