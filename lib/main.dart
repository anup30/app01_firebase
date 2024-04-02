// app added to firebase project
// guide: https://firebase.google.com/docs/flutter/setup?platform=ios

// random Color // use stream/concurrency for large ListTile ?
// issue: color flickering on hot reload, for function usage. build gets called twice without setState (v2, with solution)
// see also: https://stackoverflow.com/questions/64834702/why-build-function-gets-called-twice-when-hot-restarting
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
  //Color myColor=randColor();
  Color val = Colors.primaries[math.Random().nextInt(Colors.primaries.length)].withOpacity(0.5);
  //to fix the flickering error get color1, color2, color3 here, before build -------------
  List<Color> lc=[];
  void setColors(){
    lc =
    [ // can use list generate for many colors
      Colors.primaries[math.Random().nextInt(Colors.primaries.length)].withOpacity(0.8), // has transparency? check in a Stack, with background image.
      Colors.primaries[math.Random().nextInt(Colors.primaries.length)].withOpacity(0.8),
      Colors.primaries[math.Random().nextInt(Colors.primaries.length)].withOpacity(0.8),
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
        backgroundColor:  lc[0], //if randColor() function is used in all places, build(BuildContext context) is called twice and color changes twice.
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width:300,
              height: 100,
              color:  lc[1], //randColor() ----------------------------------------
            ),
            const SizedBox(height: 24,),
            Container(
              width:300,
              height: 100,
              color:  lc[2], // randColor()----------------------------------------
            ),
            const SizedBox(height: 8,),
            ElevatedButton(
              onPressed: () {
                setState(() { // ------------> does it call initState ? no?
                  setColors(); ///
                });
              },
              child: const Text('setState'),
            ),
          ],
        ),
      ),
    );
  }
// same effect if randColor() is written here.
}

Color randColor(){ //function
  Color myColor = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.8); //withOpacity(0.5)
  return myColor;
}

class RandColor{ // class
  static Color val = Colors.primaries[math.Random().nextInt(Colors.primaries.length)]; //.withOpacity(0.5) ->//
  static Color color(){
    //Color val = Colors.primaries[math.Random().nextInt(Colors.primaries.length)]; //.withOpacity(0.5) // ^
    return val;
  }
}

// myColor: non-flick,same for all, no setState change
// RandColor.color(): non-flick, same for all, no setState change
// randColor(): color-flick, different color for all, setState changes,