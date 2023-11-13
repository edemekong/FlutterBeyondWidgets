import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:openweather_app/ui/components/bottom_navigation_bar.dart';

class TabOverlay extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;
  const TabOverlay({required this.navigationShell, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    return Scaffold(
      bottomNavigationBar: AppBottomNavigationBar(shell: navigationShell,),
      body: ClipRRect(child: navigationShell,),
    );
  }
}