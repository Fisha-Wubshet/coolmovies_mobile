import '../Utils/brand_color.dart';
import '../model/model.dart';
import '../service/service.dart';
import '../widgets/appBar_widget.dart';
import '../widgets/single_movie_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'movie_detail.dart';
import 'provider/provider.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});
  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
bool _isLoading=false;
late List<Movie> movies; 
  @override
  void initState() {
    // fetch movies
    fechMovies();
    super.initState();
  }

  fechMovies() async {
    setState(() {
      _isLoading=true;
    }); 
    movies = await MovieService.fetchMovies();
    Provider.of<MovieListProvider>(context,listen: false).updateMovies(movies);
    setState(() {
      _isLoading=false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandBackgroundColor,
      appBar: topAppBar('Movie Review App'),
      body: _isLoading?  const Center(child: CircularProgressIndicator()):
      SingleChildScrollView(
        child:  Column(
            children: [
           const SizedBox(height: 10,),
              Padding(
                                padding: const EdgeInsets.only(left: 8, right: 8),
                                child: Consumer<MovieListProvider>(
                   builder: (context, movieProvider, child) =>GridView.builder(
                                    physics: const ClampingScrollPhysics(),
                                    primary: false,
                                    shrinkWrap: true,
                                    itemCount: movieProvider.movies.length,
                                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                        mainAxisExtent: 280, maxCrossAxisExtent: 270),
                                    itemBuilder: (BuildContext context, int index) {
                                      return  Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                         onTap: ()=> Navigator.push(
                                                      context,
                                               MaterialPageRoute(builder: (context) => MovieDetails(movieProvider.movies[index], index)),
                                              ),
                                            child: SingleMovieWidget(
                                            movie: movieProvider.movies[index],
                                          ),
                                          ),
                                        
                                      );
                                    }),
                              ),)
            ],
          ),
      ),
    );
  }
}