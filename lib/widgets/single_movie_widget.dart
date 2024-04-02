
import 'package:flutter/material.dart';
import '../model/model.dart';
class SingleMovieWidget extends StatelessWidget {
    final Movie  movie;
  const SingleMovieWidget({super.key, 
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
 decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7), color: Colors.white,
            boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.05),
          spreadRadius: 2,
          blurRadius: 2,
          offset: const Offset(0, 2), // changes position of shadow
        ),
      ], ),
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              image: DecorationImage(
                  image: NetworkImage(
                    movie.imgUrl,
                  ),
                  fit: BoxFit.cover),
            ),
            height: 220,
          ),

          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                    padding:  const EdgeInsets.only(right: 3,left: 3),
                    child:  Text(
                     movie.title,
                      style: const TextStyle(
                          fontSize: 14,
                          
                          fontWeight: FontWeight.bold,
                         ),
                         textAlign:  TextAlign.center,
                         maxLines: 2,
                         overflow: TextOverflow.ellipsis,
                    ),
                  ),
            ),
          ),
        ],
      ), // where to position the child
      /* add child content here */
    );
  }
}

