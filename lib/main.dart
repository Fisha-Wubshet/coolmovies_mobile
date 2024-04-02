import 'package:coolmovies_mobile/movie_list.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Review App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MovieList(),
    );
  }
}


