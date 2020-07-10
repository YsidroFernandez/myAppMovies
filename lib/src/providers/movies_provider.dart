import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:app_movies/src/models/movie_model.dart';
import 'package:app_movies/src/models/actors_model.dart';


class MoviesProvider {
   String _apiKey = '7c2c097f4527acbefd83ef571243b38e';
   String _apiUrl = 'api.themoviedb.org';
   String _language = 'es-ES';
   int _popularesPage = 0;
   bool _isLoading = false;

   List<Movie> _populares = new List();

   final _popularesStreamController = StreamController<List<Movie>>.broadcast();

    //Añadir información al flujo para que sea procesada para ello se usa en "SINK"
   Function(List<Movie>) get populareSink => _popularesStreamController.sink.add;

    //Salida de la informacion con el STREAM

   Stream <List<Movie>> get popularesStream  => _popularesStreamController.stream;

  //Cierra la conexión con el streamController una vez que deja de usarse
   void disposeStream(){
     _popularesStreamController?.close();
   }

  Future<List<Movie>>getResponseUrl(Uri url) async{

    final response = await http.get(url);

    final data = json.decode(response.body);

    final movies = new Movies.formJsonList(data['results']);


    return movies.items;

  }

  Future<List<Movie>>getEncines() async{

    final url = Uri.https(_apiUrl,'3/movie/now_playing',{
      'api_key' : _apiKey,
      'language': _language,
    });

    return await getResponseUrl(url);

  }


   Future<List<Movie>> getPopulares() async{

     if(_isLoading) return [];

     _isLoading = true;
     _popularesPage++;

    final url = Uri.https(_apiUrl,'3/movie/popular',{
      'api_key' : _apiKey,
      'language': _language,
      'page' : _popularesPage.toString()
    });

    final response =  await getResponseUrl(url);
    _populares.addAll(response);

    populareSink(_populares);
    _isLoading = false;
    return response;

  }
  
   Future<List<Actor>> getCast(String idMovie) async{

    final url = Uri.https(_apiUrl,'3/movie/$idMovie/credits',{
      'api_key' : _apiKey,
      'language': _language,
    });

    final response = await http.get(url);

    final dataCast = json.decode(response.body);

      final actors = new Actors.formJsonList(dataCast['cast']);


    return actors.listActors;


  }


  Future<List<Movie>>searchMovie(String query) async{

    final url = Uri.https(_apiUrl,'3/search/movie',{
      'api_key' : _apiKey,
      'language': _language,
      'query'   : query
    });

    return await getResponseUrl(url);

  }

}