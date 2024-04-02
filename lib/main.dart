// app added to firebase project
// guide: https://firebase.google.com/docs/flutter/setup?platform=ios

//test 01
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // <-- for firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color val = Colors.primaries[math.Random().nextInt(Colors.primaries.length)]
      .withOpacity(0.5);

  List<Color> lc = [];

  void setColors() {
    lc = [
      Colors.primaries[math.Random().nextInt(Colors.primaries.length)]
          .withOpacity(0.8),
      Colors.primaries[math.Random().nextInt(Colors.primaries.length)]
          .withOpacity(0.8),
    ];
  }

  @override
  void initState() {
    super.initState();
    setColors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  color: lc[0],
                ),
                const SizedBox(
                  width: 24,
                ),
                Container(
                  width: 100,
                  height: 100,
                  color: lc[1],
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {setColors();});
              },
              child: const Text('setState'),
            ),
          ],
        ),
      ),
    );
  }
}