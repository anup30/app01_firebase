// app added to firebase project
// guide: https://firebase.google.com/docs/flutter/setup?platform=ios

import 'package:app01/movie.dart';
import 'package:app01/movie_list_screen2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:app01/movie_list_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

List<Movie> mList =[];
// firebase class2, on time at: 40:00
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // <-- for firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  mList = await getMovieList();
  await Future.delayed(const Duration(seconds: 3)); /// <------------
  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MovieListScreen2(), // try, MovieListScreen4016()
    );
  }
}

Future <List<Movie>> getMovieList()async{ //statically fetch
  await Future.delayed(Duration.zero); // <-- Add a 0 dummy waiting time
  final List<Movie> mList2 =[];
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  firebaseFirestore.collection('movies').get().then((value){ // <--- where from ? , class 2, Getting all documents from one collection
    //print(value); //Instance of '_JsonQuerySnapshot'
    //MovieListScreen4016.movieList.clear();
    for(QueryDocumentSnapshot doc in value.docs){ // or var doc, class 2 <---
      print(doc.data()); // prints my firestore 'movies' data //ok
      //MovieListScreen4016.movieList.add(Movie.fromJson(doc.id, doc.data() as Map<String,dynamic>),);
      mList2.add(Movie.fromJson(doc.id, doc.data() as Map<String,dynamic>),);
    }
    print("movieList length = ${mList2.length}"); //ok
    print("name[0]=${mList2[0].name}"); //ok
  });
  return mList2;
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