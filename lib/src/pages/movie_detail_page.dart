import 'package:flutter/material.dart';
import 'package:app_movies/src/models/movie_model.dart';
import 'package:app_movies/src/providers/movies_provider.dart';
import 'package:app_movies/src/models/actors_model.dart';


class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10.0),
              _posterTitle(context, movie),
              _description(movie),
              _getActors(movie),
              
            ]),
          )
        ],
    ));
  }

  Widget _createAppBar(Movie movie) {
    return SliverAppBar(
        elevation: 2.0,
        backgroundColor: Colors.indigoAccent,
        expandedHeight: 200.0,
        floating: false,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(movie.title),
          background: FadeInImage(
            placeholder: AssetImage('assets/img/loading.gif'),
            image: NetworkImage(movie.getImgBackground()),
            fadeInDuration: Duration(seconds: 2),
            fit: BoxFit.cover,
          ),
        ));
  }

  Widget _posterTitle(BuildContext context, Movie movie) {
    return Container(
      margin: EdgeInsets.only(left: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0), 
              child: Image(
                image: NetworkImage(movie.getImgApi()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                movie.title,
                style: Theme.of(context).textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                movie.originalTitle,
                style: Theme.of(context).textTheme.subtitle2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.star_half),
                  Text(
                    movie.voteAverage.toString(),
                    style: Theme.of(context).textTheme.subtitle2,
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  _description(Movie movie) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal:20.0, vertical:20.0),
      child: Text(movie.overview, textAlign: TextAlign.justify,),
    );
  }

  Widget _getActors(Movie movie) {

    final movieProvider = new MoviesProvider();

    return FutureBuilder(
      future: movieProvider.getCast(movie.id.toString()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          return _createPageViewActors(snapshot.data);
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );

  }

  Widget _createPageViewActors(List<Actor> actores) {

    return SizedBox(
      height: 300.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        itemCount: actores.length,
        itemBuilder: (context, i){
          return _cardActor(actores[i]);
        },
      ),
    );

  }

  Widget _cardActor(Actor actor) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal:5.0,vertical:5.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/loading.gif'), 
              image: NetworkImage( actor.getImgProfileActor()),
              fit: BoxFit.cover,  
            ),
          ),
          Text(actor.name),
        ],
      ),
    );
  }
}
