
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
  final TextEditingController titleController =  TextEditingController();
  final TextEditingController bodyController =  TextEditingController();
  int  _reviewStars = 0;
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
// add review 
  addReview() async {
    setState(() {
      _isLoading=true;
    });
  String userReviewerId = await MovieService.fetchCurrentUser(); 
  allMovies = await MovieService.addReview(movie.id,userReviewerId,titleController.text,_reviewStars,bodyController.text); 
   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Review successfully "),backgroundColor: Colors.green,));
    setState(() {
       Provider.of<MovieListProvider>(context,listen: false).updateMovies(allMovies);
       movieReviews=allMovies[widget.index].movieReviews;
      _isLoading=false
      ;
    });
  }

  // check onine status
Future<bool> checkOnline() async {
  final result = await Connectivity().checkConnectivity();
  return result == ConnectivityResult.mobile || result == ConnectivityResult.wifi;
}

// remove review 
  removeReview(reviewId) async {
    setState(() {
      _isLoading=true;
    });
    bool isOnline=false;
    // check online status
    isOnline = await checkOnline();
    if(isOnline){
    allMovies = await MovieService.deleteReview(reviewId);}
    
    setState(() {
     Provider.of<MovieListProvider>(context,listen: false).updateMovies(allMovies);
      movieReviews=allMovies[widget.index].movieReviews;
      _isLoading=false;
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
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                          itemCount:movieReviews.length,
                          itemBuilder: (context, index) {
                          
                            return 
                              reviewList(movieReviews[index]);
                          },
                        ),
                    ),
                    const SizedBox(height: 100,),
                 
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
                         titleController.text='';
                         bodyController.text='';
                         _reviewStars = 0;
                          addReviewWidget();
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
  reviewList(review){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
              Text(review.title,style: 
                const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold
                 ),),
                  // only the review creater can delete
                 if(userReviewerId==review.userCreatorId)
                 InkWell(
                  onTap: (){
                    removeReview(review.id);
                  },
                  child: const Icon(Icons.delete))
            ],
          ),
          if(review.rating!=null)
          Row(
              children: [
                   for (int i = 1; i <= 5; i++)
                   Icon( Icons.star,
                   color: review.rating >= i ? Colors.amber : Colors.grey,size: 15,
                ),
                  ],
                    ),
                    
                    Text(review.userCreator ,style: 
                            const TextStyle(
                           fontSize: 16,
                           ),),
                           if(review.body!=null)
                           Text(review.body,style: 
                           const TextStyle(
                          fontSize: 14,
                      color: Colors.grey
                        ),),       
           const Padding(
             padding: EdgeInsets.all(8.0),
             child: Divider(color: Colors.grey,),
           ),
        ],
      ),
    );
  }

  //widget to add a review
addReviewWidget() {
    return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) { return StatefulBuilder(
                builder: (context, setState) {
                  return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
               padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                
                    children: [
                const Icon(Icons.star_border, size: 35,),
                const SizedBox(height: 5,),
                      const  Text('RATE THIS', style: TextStyle(
                                color:  primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                
                            ),),
                            const  SizedBox(height: 5,),
                            Text(movie.title, style:  const TextStyle(
                                color:  Colors.black,
                                fontSize: 20,
                                
                
                            ),
                            textAlign: TextAlign.center,
                            ),
                    
                            // ReviewList(reviews, deleteReview), // Pass deleteReview function
                            Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    // key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(labelText: "Review Title"),
                          controller: titleController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter a title for your review";
                            }
                            return null;
                          },
                      
                        ),
                        TextFormField(
                          decoration: const InputDecoration(labelText: "Review Body"),
                          controller: bodyController,
                          
                       
                          minLines: 3,
                          maxLines: 5,
                        ),
                        Row(
                          children: [
                            for (int i = 1; i <= 5; i++)
                              IconButton(
                                icon: Icon(
                                  Icons.star,
                                  color: _reviewStars >= i ? Colors.amber : Colors.grey,
                                ),
                                onPressed: () => setState(() => _reviewStars = i),
                              ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 56.0,
                      child: ElevatedButton(
                        style: raisedButtonStyle,
                        onPressed: () {
                          if(titleController.text!='')
                            { Navigator.of(context).pop();
                             addReview();}
                             else{
                             Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Title field is required "),backgroundColor: Colors.red,));
                             }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                             Icon(Icons.star),
                            SizedBox(width: 10,),
                            Text("Submit Review",style: TextStyle(
                              fontSize: 16,
                              fontWeight:  FontWeight.bold,
                            ),),
                          ],
                        ),
                      ),
                    
                  ),
                      ],
                    ),
                  ),
                            ),
                          
                    ],
                  ),
                ),
              ),
            ),
          );}
            ); });
  }
  
}
