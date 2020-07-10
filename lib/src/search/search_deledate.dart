import 'package:flutter/material.dart';
import 'package:app_movies/src/providers/movies_provider.dart';
import 'package:app_movies/src/models/movie_model.dart';


class DataSearch extends SearchDelegate {

  String selected ='';

  final moviesProvider = new MoviesProvider();

  final movies =[
    'Spiderman',
    'Acuaman',
    'Batman',
    'Shazan!',
    'Iroman',
    'Capitan América'
  ];

  final recentMovies=[
    'Spiderman',
    'Capitan América'
  ];


  @override
  List<Widget> buildActions(BuildContext context) {
    // son las acciones de nuestro appBar

    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query='';
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // corresponde al ícono que aparece en el inicio del AppBar
    return IconButton(icon: AnimatedIcon(
      icon: AnimatedIcons.menu_arrow, 
      progress: transitionAnimation) , 
      onPressed: (){
        close(context,null);
      });
  }

  @override
  Widget buildResults(BuildContext context) {
    //crea los resultados que se van a mostrar
    return Container();

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //son las sugerencias que aparecen cuando se va escribiendo

    if(query.isEmpty){
      return Container();
    }

    return FutureBuilder(
      future: moviesProvider.searchMovie(query) ,
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {

        final listMovies = snapshot.data;
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: listMovies.length,
            itemBuilder: (context,i){
              return ListTile(
                leading: FadeInImage(
                  placeholder: AssetImage('assets/img/loading.gif'), 
                  image: NetworkImage(listMovies[i].getImgBackground()),
                  fit: BoxFit.cover,),
                  title: Text(listMovies[i].title),
                  subtitle: Text(listMovies[i].overview),
                  onTap: (){
                    close(context, null);
                    listMovies[i].uniqueId='';
                    Navigator.pushNamed(context, 'detail',arguments: listMovies[i]);

                  },
              );   
            }
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );



    // final listSuggestion =  (query.isEmpty) ? recentMovies : movies.where((element) => element.toLowerCase().startsWith(query.toLowerCase())).toList();


    // return ListView.builder(
    //   itemCount: listSuggestion.length,
    //   itemBuilder: (context,i){
    //     return ListTile(
    //       leading: Icon(Icons.movie),
    //       title: Text(listSuggestion[i]),
    //       onTap: (){
    //         selected = listSuggestion[i];
    //         showResults(context);
    //       },
    //     );
    //   }
    // );
  }
}
