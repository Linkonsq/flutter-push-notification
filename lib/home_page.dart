import 'package:flutter/material.dart';
import 'package:push_notifications/plant_stats_page.dart';
import 'package:push_notifications/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppBarTitle(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PlantStatsPage(),
                ),
              );
            },
            icon: Icon(
              Icons.insert_chart_outlined_rounded,
              size: 30,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlantImage(),
            SizedBox(
              height: 25,
            ),
            HomePageButtons(
              onPressedOne: () async {},
              onPressedTwo: () async {},
              onPressedThree: () async {},
            ),
          ],
        ),
      ),
    );
  }
}