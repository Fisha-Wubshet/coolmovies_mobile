
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Utils/Utils.dart';
import 'Utils/brand_color.dart';
import 'model/model.dart';
import 'provider/provider.dart';
import 'service/service.dart';


class MovieDetails extends StatefulWidget {
  final Movie  movie;
  final int index;
  const MovieDetails(this.movie, this.index, {super.key});
  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {

  late List movieReviews;
  late Movie movie;
  late List<Movie> allMovies;
  late String userReviewerId;
  bool _isLoading=false;

@override
  void initState() {
    fetchDetails();
    super.initState();
  }
  fetchDetails() async {
    setState(() {
      _isLoading=true;
    });
    // value assign
    movie=widget.movie;
    movieReviews=widget.movie.movieReviews;
    userReviewerId = await MovieService.fetchCurrentUser(); 
    setState(() {
      _isLoading=false
      ;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading?  const Center(child: CircularProgressIndicator()):
      SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height:  MediaQuery.of(context).size.height*0.5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          
                          fit: BoxFit.cover,
                          image:  Image(
                              image: NetworkImage(movie.imgUrl),
                             ).image,
                        ),
                      ),
                  child:  Stack(
                    children: [
                      Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: InkWell(
                                    onTap: (){
                                      Navigator.of(context).pop();
                                    },
                                    child: Padding(
                                       padding: const EdgeInsets.only(top: 25),
                                     child:Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white70,
                                                    ),
                                                    // ignore: sort_child_properties_last
                                                    child: const Icon(Icons.arrow_back_ios_sharp, color: primaryColor),
                                                    alignment: Alignment.center,
                                                  )),
                                  ),
                               ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Container(
                                         decoration: const BoxDecoration(
                                          color: Colors.black54,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              
                                                              Expanded(
                                                                child: Text(movie.title, style: const TextStyle(
                                                                                     fontSize: 16,
                                                                                fontFamily: 'Inter',
                                                                                fontWeight: FontWeight.w800,
                                                                                color:  Colors.white),),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(height: 5,),
                                                          Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Text(movie.releaseDate!,style: const TextStyle(
                                                                                       fontSize: 14,
                                                                                  fontFamily: 'Inter',
                                                                                
                                                                                  color:  Colors.white) ),
                                                          ),
                                                  
                                                         
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  
                                  ],
                                ),
                                  
                    ],
                  ),
                    ),
               
                  
                 
              ],
                ),
                        
              ),
                bottomSheet: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 56.0,
                    child: ElevatedButton(
                      style: raisedButtonStyle,
                      onPressed: () {
                        
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.star),
                          SizedBox(width: 10,),
                          Text('RATE THIS',style: TextStyle(
                            fontSize: 16,
                            fontWeight:  FontWeight.bold,
                          ),),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }

  //widget to list a single review

}
