import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_provider/providers/movie_provider.dart';
import './Screens/fav_movies.dart';

void main() {
  runApp(ChangeNotifierProvider<MovieProvider>(
    child: const MyApp(),
    create: (_) => MovieProvider(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var movies = context.watch<MovieProvider>().movies;
    var myList = context.watch<MovieProvider>().myList;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        centerTitle: true,
        title: const Text('Provider'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MyListScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.favorite),
              label: Text(
                '${myList.length}',
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (_, index) {
                  final currentMovie = movies[index];
                  return Card(
                    key: ValueKey(currentMovie.title),
                    color: Colors.purple[900],
                    elevation: 4,
                    child: ListTile(
                      title: Text(
                        currentMovie.title,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        currentMovie.duration,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: myList.contains(currentMovie)
                              ? Colors.red[600]
                              : Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          if (!myList.contains(currentMovie)) {
                            context
                                .read<MovieProvider>()
                                .addToList(currentMovie);
                          } else {
                            context
                                .read<MovieProvider>()
                                .removeFromList(currentMovie);
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
