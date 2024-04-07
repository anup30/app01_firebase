// app added to firebase project
// guide: https://firebase.google.com/docs/flutter/setup?platform=ios

import 'package:app01/movie_list_at40.16.dart';
//import 'package:app01/movie_list_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

// firebase class2, on time at: 40:00
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // <-- for firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MovieListScreen4016(), // try, MovieListScreen4016()
    );
  }
}


//the (my) database is in test mode(anyone can modify)-------

/*
for error:
ERROR:D8: Cannot fit requested classes in a single dex file (# methods: 94247 > 65536)
com.android.builder.dexing.DexArchiveMergerException: Error while merging dex archives:
The number of method references in a .dex file cannot exceed 64K. .....


in project>app>src>build.gradle file:
1) in defaultConfig {}
add, multiDexEnabled true
2) in dependencies {}
add, implementation 'com.android.support:multidex:1.0.3'
*/