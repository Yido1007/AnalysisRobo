import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/bottommenu.dart';

class HomeScreen extends StatefulWidget {
  final Widget child;
  final GoRouterState state;
  const HomeScreen({super.key, required this.child, required this.state});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Analysis Robo'),
          centerTitle: true,
        ),
        body: SafeArea(child: widget.child),
        bottomNavigationBar: BottomMenu(
          currentPath: widget.state.matchedLocation,
        ));
  }
}
