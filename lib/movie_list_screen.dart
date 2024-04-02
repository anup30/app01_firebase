import 'package:flutter/material.dart';

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Movies"),backgroundColor: Colors.blue),
      body: ListView.separated(
        itemCount: 10,
        itemBuilder: (context,index){
          return ListTile(
            title: Text("Movie Name"),
            subtitle: Text("Languages"),
            leading: Text("1.4"),
            trailing: Text("2021"),
          );
        },
        separatorBuilder:(_,__)=> const Divider(),
      ),
    );
  }
}