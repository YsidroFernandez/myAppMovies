import 'package:flutter/material.dart';
import 'package:app_movies/src/widgets/card_swiper.dart';
import 'package:app_movies/src/providers/movies_provider.dart';
import 'package:app_movies/src/widgets/movie_horizontal.dart';
import 'package:app_movies/src/search/search_deledate.dart';

class HomePage extends StatelessWidget {
  final movieProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    //Llamamos el listados de las películas más populares cuando se construya
    //el Widget por primera vez, ésta función a su vez llama al método sink del patrón bloc para que se mantenga escuchando
    // cada vez que se requiera llamar a la siguiente página del servicio getPopulares

    movieProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Home Page'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              })
        ],
      ),
      body:SingleChildScrollView(
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperCards(),
            _footer(context),
          ],
        )),
      ),
    );
  }

  Widget _swiperCards() {
    return FutureBuilder(
      future: movieProvider.getEncines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(data: snapshot.data);
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Text(
            'Más populares',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 5.0,
          ),
          StreamBuilder(
              stream: movieProvider.popularesStream,
              builder: (context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  return MovieHorizontal(
                    moviesList: snapshot.data,
                    nextPage: movieProvider.getPopulares,
                  );
                } else {
                  return Container(
                      child: Center(child: CircularProgressIndicator()));
                }
              })
        ],
      ),
    );
  }
}
