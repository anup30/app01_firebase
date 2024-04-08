import 'package:app01/movie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MovieListScreen2 extends StatefulWidget { /// up to 40:16 of firebase class 2 video
  const MovieListScreen2({super.key});
  static List<Movie> movieList =[];
  @override
  State<MovieListScreen2> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen2> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance; // https://firebase.google.com/docs/storage/flutter/start
  final List<Movie> movieList =[];
  // @override
  // void initState() {
  //   super.initState();
  //   //_getMovieList(); // <--------- getting problem if initialized here, latter building body.
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { _getMovieList();});
    //_getMovieList();
  }

  Future <void> _getMovieList()async{ //statically fetch
    await Future.delayed(Duration.zero); // <--- Add a 0 dummy waiting time, write inside build ?
    _firebaseFirestore.collection('movies').get().then((value){ // <--- where from ? , class 2, Getting all documents from one collection
      //print(value); //Instance of '_JsonQuerySnapshot'
      movieList.clear();
      for(QueryDocumentSnapshot doc in value.docs){ // or var doc, class 2 <---
        print(doc.data()); // prints my firestore 'movies' data //ok
        movieList.add(Movie.fromJson(doc.id, doc.data() as Map<String,dynamic>),);
      }
      print("movieList length = ${movieList.length}"); //ok
      print("name[0]=${movieList[0].name}"); //ok
      setState(() {});
    });
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
        itemCount: movieList.length, // <--- empty list?
        itemBuilder: (context,index){
          return ListTile(
            title: Text(movieList[index].name),
            subtitle: Text(movieList[index].languages),
            leading: Text(movieList[index].rating),
            trailing: Text(movieList[index].year),
          );
        },
        separatorBuilder:(_,__)=> const Divider(),
      ),
    );
  }
}