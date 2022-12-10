import 'package:flutter/material.dart';
import 'package:flutter_provider/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class MyListScreen extends StatefulWidget {
  const MyListScreen({super.key});

  @override
  State<MyListScreen> createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> {
  @override
  Widget build(BuildContext context) {
    final myList = context.watch<MovieProvider>().myList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        centerTitle: true,
        title: Text('Favourites ${myList.length}'),
      ),
      body: ListView.builder(
        itemCount: myList.length,
        itemBuilder: (_, index) {
          final currentMovie = myList[index];
          return Card(
            key: ValueKey(currentMovie.title),
            elevation: 4,
            child: ListTile(
              title: Text(currentMovie.title),
              subtitle: Text(currentMovie.duration),
              trailing: IconButton(
                onPressed: () {
                  context.read<MovieProvider>().removeFromList(currentMovie);
                },
                icon: const Icon(
                  Icons.local_fire_department,
                  color: Colors.red,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
