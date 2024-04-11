// app added to firebase project 🔥
// guide: https://firebase.google.com/docs/flutter/setup?platform=ios



import 'package:app01/upload_image_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
//import 'package:app01/flutter_fly.dart';
//import 'package:app01/movie_list_screen2.dart';
//import 'package:app01/movie_list_screen3.dart';
//import 'package:app01/f_storage.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // <-- for firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //await Future.delayed(const Duration(seconds: 2)); /// <---
  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: UploadImageScreen(), //  StorageScreen
    );
  }
}

//the (my) database is in test mode(anyone can modify) <------

/*
for error:
ERROR:D8: Cannot fit requested classes in a single dex file (# methods: 94247 > 65536)
com.android.builder.dexing.DexArchiveMergerException: Error while merging dex archives:
The number of method references in a .dex file cannot exceed 64K. .....


set minSdkVersion 21 in in project>android>app>src>build.gradle file.
or,
in project>android>app>src>build.gradle file:
1) in defaultConfig {}
add, multiDexEnabled true
2) in dependencies {}
add, implementation 'com.android.support:multidex:1.0.3'
*/

/*
  Documentation> Cloud Storage for Firebase
  build>Firestore
  Cloud Firestore(for text data)

  on left pane,
  1) get started... (add data/ read data)
  go console, project, on left pane, Firestore Database, Start collection -> add data manually,
  2) Read data -> get real-time updates
  3) add and manage data -> delete data

  my project -> build -> storage
*/

// assignment:
// TO DO: 1. set up firebase storage
// TO DO: 2. pick new image/videos from gallery and put into firebase storage
// TO DO: 3. show list of images from storage in gridview