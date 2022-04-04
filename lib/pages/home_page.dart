import 'package:flutter/material.dart';
import 'package:test_project/pages/sliding_card_view.dart';
import 'package:test_project/pages/tabs.dart';

class MyHomePage extends StatefulWidget {
  String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8 + MediaQuery.of(context).padding.top,
            ),
            const Header(),
            const SizedBox(height: 40),
            Tabs(),
            const SizedBox(height: 18),
            const Expanded(child: SlidingCardsView()),
          ],
        ),

    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Text(
        'Shenzhen',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
