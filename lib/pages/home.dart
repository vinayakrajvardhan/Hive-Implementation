import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box homeBox;
  @override
  void initState() {
    homeBox = Hive.box('home');
    homeBox.put(1, "Hive");
    homeBox.put(2, "Flutter");
    homeBox.putAll({
      3: "good",
      4: "day",
    });
    homeBox.add('Dewan');
    homeBox.put('5', 'Pan');
    homeBox.add('Van');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            homeBox.get(1),
          ),
          Text(
            homeBox.get(2),
          ),
          Text(homeBox.get(4)),
          Text(homeBox.getAt(0)),
          Text(homeBox.get(4)),
          Text(homeBox.getAt(1)),
        ],
      ),
    );
  }
}
