import 'package:app01/movie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app01/main.dart';
//import 'package:flutter/scheduler.dart';

class MovieListScreen2 extends StatefulWidget { /// up to 40:16 of firebase class 2 video
  const MovieListScreen2({super.key});
  static List<Movie> movieList =[];
  @override
  State<MovieListScreen2> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen2> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance; // https://firebase.google.com/docs/storage/flutter/start
  //final List<Movie> movieList =[];
  // @override
  // void initState() {
  //   super.initState();
  //   //_getMovieList(); // <--------- getting problem if initialized here, latter building body.
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { getMovieList();});
    //_getMovieList();
  }

  // Future <void> _getMovieList()async{ //statically fetch
  //   _firebaseFirestore.collection('movies').get().then((value){ // <--- where from ? , class 2, Getting all documents from one collection
  //     //print(value); //Instance of '_JsonQuerySnapshot'
  //     MovieListScreen4016.movieList.clear();
  //     for(QueryDocumentSnapshot doc in value.docs){ // or var doc, class 2 <---
  //       print(doc.data()); // prints my firestore 'movies' data //ok
  //       MovieListScreen4016.movieList.add(Movie.fromJson(doc.id, doc.data() as Map<String,dynamic>),);
  //     }
  //     print("movieList length = ${MovieListScreen4016.movieList.length}"); //ok
  //     print("name[0]=${MovieListScreen4016.movieList[0].name}"); //ok
  //   });
  // }

  Future<Widget> myFunc()async{
    _firebaseFirestore.collection('movies').get().then((value){ // <--- where from ? , class 2, Getting all documents from one collection
      //print(value);
      MovieListScreen2.movieList.clear();
      for(QueryDocumentSnapshot doc in value.docs){ // or var doc, class 2 <---
        print(doc.data()); // prints my firestore 'movies' data //ok
        MovieListScreen2.movieList.add(Movie.fromJson(doc.id, doc.data() as Map<String,dynamic>),);
      }
      print("movieList length = ${MovieListScreen2.movieList.length}");
      print("name[0]=${MovieListScreen2.movieList[0].name}");
    });
    return Text("a Text Widget");//movieList[0].name;
  }
  @override
  Widget build(BuildContext context) {
    ///WidgetsBinding.instance.addPostFrameCallback((_) => _getMovieList());
    //SchedulerBinding.instance.addPostFrameCallback((_) {getMovieList(); });
    return Scaffold(
      appBar: AppBar(title: const Text("Movies"),backgroundColor: Colors.blue),
      /*body: Center(
        //child: Text(movieList[0].name), ///RangeError (index): Invalid value: Valid value range is empty: 0
        //child: myFunc(); // The argument type 'Future<Widget>' can't be assigned to the parameter type 'Widget?'.
        //child: MovieListScreen4016.movieList.isNotEmpty?Text("movieList.length = ${MovieListScreen4016.movieList.length}"):const Text("movieList.length is 0"),
        child: mList.isNotEmpty?Text("movieList length = ${mList.length}"):const Text("movieList is empty"), // mList from main page.
        // ^ getting empty list here, but had elements in initState print! ------------------------------------------------------------------------------------------
      ),*/
      body: ListView.separated(
        itemCount: mList.length, // <--- empty list
        itemBuilder: (context,index){
          return ListTile(
            title: Text(mList[index].name),
            subtitle: Text(mList[index].languages),
            leading: Text(mList[index].rating),
            trailing: Text(mList[index].year),
          );
        },
        separatorBuilder:(_,__)=> const Divider(),
      ),
    );
  }
}