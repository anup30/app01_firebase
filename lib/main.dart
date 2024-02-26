// random Color
// https://stackoverflow.com/questions/51340588/flutter-how-can-i-make-a-random-color-generator-background
// issue: color flickering on hot reload, for function usage.
import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
        backgroundColor:  randColor(), //--------------------------------------
        // myColor: non-flick,same for all, no setState change
        // RandColor.color(): non-flick, same for all, no setState change
        // randColor(): color-flick, different color for all, setState changes,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width:300,
              height: 100,
              color:  randColor(), // ----------------------------------------
            ),
            const SizedBox(height: 24,),
            Container(
              width:300,
              height: 100,
              color:  randColor(), // ----------------------------------------
            ),
            const SizedBox(height: 8,),
            ElevatedButton(
              onPressed: () {
                setState(() {}); // appBar color is fixed!
              },
              child: const Text('setState'),
            ),
          ],
        ),
      ),
    );
  }
}

Color randColor(){ //function
  //WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    Color myColor = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.8); //withOpacity(0.5)
    return myColor;
  // });
  // return Colors.blue;

}

class RandColor{ // class
  static Color val = Colors.primaries[math.Random().nextInt(Colors.primaries.length)]; //.withOpacity(0.5) ->//
  static Color color(){
    //Color val = Colors.primaries[math.Random().nextInt(Colors.primaries.length)]; //.withOpacity(0.5) // ^
    return val;
  }
}