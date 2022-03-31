import 'package:flutter/material.dart';
import 'package:test_project/sliding_card_view.dart';
import 'package:test_project/tabs.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 8 + MediaQuery.of(context).padding.top,
          ),
          const Header(),
          const SizedBox(height: 40),
          Tabs(),
          const SizedBox(height: 18),
          const SlidingCardsView(),
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
