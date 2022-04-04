import 'package:flutter/material.dart';
import 'dart:math';

import 'package:test_project/flutter_chart/demo_chart.dart';
import 'package:test_project/syncfusion_chart/syncfusion_chart.dart';
class SlidingCardsView extends StatefulWidget {
  const SlidingCardsView({Key? key}) : super(key: key);

  @override
  State<SlidingCardsView> createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  double pageOffset = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController.addListener(() {
      setState(() {
        pageOffset = _pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery
          .of(context)
          .size
          .height * 0.6,
      child: PageView(
        controller: _pageController,
        children:  [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => DemoChart(),));
            },
            child: SlidingCard(
              name: 'Shenzhen GLOBAL DESIGN AWARD 2018',
              date: '4.20-30',
              assetName: 'steve-johnson.jpeg',
              offset: pageOffset,
            ),
          ),
          SlidingCard(
            name: 'Dawan District, Guangdong Hong Kong and Macao',
            date: '4.28-31',
            assetName: 'rodion-kutsaev.jpeg',
            offset: pageOffset -1,
          ),
        ],
      ),
    );
  }
}

class SlidingCard extends StatelessWidget {
  final String name; //<-- title of the event
  final String date; //<-- date of the event
  final String assetName; //<-- name of the image to be displayed
  final double offset;             //<-- How far is page from being displayed

  const SlidingCard({
    Key? key,
    required this.name,
    required this.date,
    required this.assetName,
    required this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gauss = exp(-(pow((offset.abs() - 0.5), 2) / 0.08));
    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
      child: Card(
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 24),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        //<--custom shape
        child: Column(
          children: <Widget>[
            ClipRRect(
              //<--clipping image
              borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
              child: Image.asset(
                //<-- main image
                'assets/$assetName',
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.3,
                fit: BoxFit.cover,
                alignment: Alignment(-offset.abs(),0),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: CardContent(
                name: name,
                date: date,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String name;
  final String date;

  const CardContent({Key? key, required this.name, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            date,
            style: TextStyle(color: Colors.grey),
          ),
          const Spacer(),
          Row(
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    primary: const Color(0xFF162A49)),
                onPressed: () {},
                child: const Text("Reserve"),
              ),
              const Spacer(),
              const Text(
                '0.00 \$',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(width: 16),
            ],
          )
        ],
      ),
    );
  }
}
