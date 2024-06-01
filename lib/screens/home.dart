import 'package:flutter/material.dart';
import '../widgets/bottommenu.dart';

class HomeScreen extends StatefulWidget {
  final Widget child;
  const HomeScreen({super.key, required this.child});

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
        bottomNavigationBar: const BottomMenu());
  }
}
