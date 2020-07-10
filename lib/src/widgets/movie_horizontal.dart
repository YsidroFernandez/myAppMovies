import 'package:flutter/material.dart';
import 'package:app_movies/src/models/movie_model.dart';


class MovieHorizontal extends StatelessWidget {

  final List<Movie> moviesList;
  final Function nextPage ;
  

  final _pageController = new PageController(
          initialPage: 1,
          viewportFraction: 0.3
        );
  MovieHorizontal({@required this.moviesList, @required this.nextPage}) ;

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;


  // Este listener se encarga de verificar si ya se ha llegado al final de la lista del Scroll horizontal
  //para cargar la nueva lista de la siguiente página, se maneja como un callback que se llama en el HomePage
    _pageController.addListener(() {

        if(_pageController.position.pixels  >= _pageController.position.maxScrollExtent -200){
          nextPage();
        }

    });



    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: moviesList.length,
        itemBuilder: ( context, i){
          return _tarjeta(context, moviesList[i]);
        },
      ),
    );
  }


  Widget _tarjeta(BuildContext context,Movie movie){

    movie.uniqueId = '${movie.id}-poster';

    final tarjeta = Container(
        margin: EdgeInsets.only(right:15.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: movie.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  height: 100.0,
                  width: 100.0,
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(movie.getImgApi()),
                  fit: BoxFit.cover
                ),
              ),
            ),
            // SizedBox(height: 4.0,),
            Text(movie.title, overflow: TextOverflow.ellipsis, style:  Theme.of(context).textTheme.caption)
          ],
        ),
      );

      return GestureDetector(
        child: tarjeta,
        onTap: (){
          Navigator.pushNamed(context, 'detail',arguments: movie);
        },
      );
  }

  List<Widget> litsTarjetas(BuildContext context) {
    return moviesList.map((movie){
      return Container(
        margin: EdgeInsets.only(right:15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                height: 100.0,
                width: 100.0,
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(movie.getImgApi()),
                fit: BoxFit.cover
              ),
            ),
            // SizedBox(height: 4.0,),
            Text(movie.title, overflow: TextOverflow.ellipsis, style:  Theme.of(context).textTheme.caption)
          ],
        ),
      );
    }).toList();
  }
}