import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;

import 'package:peliculas/models/actores_model.dart';
import 'package:peliculas/models/peliculas_model.dart';

class PeliculasProvider {
  String _apikey = '65decc06132b29f2ddb36bfbdb83276b';
  String _url = 'api.themoviedb.org';
  String _lenguaje = 'es-ES';
  int _paginaEnPopulares = 0;

  bool _cargando = false;

  // vamos hacer las definicion
  List<Pelicula> _popularesListaPelicula = [];
  // este es codigo para crear un Stream el broasdcast para que varias personas escuches o varios subscriptores
  // este la tuberia solamente
  final _popularesListaPeliculaStreamController =
      StreamController<List<Pelicula>>.broadcast();

  // con esto introducidos la peliculas o cualquire cosa esta la sixtaxis
  Function(List<Pelicula>) get popularesListaPeliculaSink =>
      _popularesListaPeliculaStreamController.sink.add;

  //para escuchar las peliculas es con Stream y se le puede decir es tipo de informacion que esta emitiendo<List<Pelota>>
  Stream<List<Pelicula>> get popularesListaPeliculaStream =>
      _popularesListaPeliculaStreamController.stream;

  void disposeStreams() {
    _popularesListaPeliculaStreamController?.close();
  }

  // vamos hacer un metodo de esta clases privados para optimizar el codigo

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final datosDecodificados = json.decode(resp.body);
    // print(datosDecodificados['results']);
    final peliculas = new Peliculas.fromJsonList(datosDecodificados['results']);

    // print(peliculas.items[3].title);

    return peliculas.items;
  }

// Vamos a los llamados de enpoind

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _lenguaje,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) {
      print('getPopulares $_paginaEnPopulares');
      return [];
    } else {
      _cargando = true;
    }

    _paginaEnPopulares++;
    // print('getPopulares $_paginaEnPopulares');

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _lenguaje,
      'page': _paginaEnPopulares.toString(),
    });

    final respuesta = await _procesarRespuesta(url);

    _popularesListaPelicula.addAll(respuesta);

    // aqui utilizamos nuestros stream
    popularesListaPeliculaSink(_popularesListaPelicula);

    _cargando = false;

    return respuesta;
  }

  Future<List<Actor>> getCastActoresDePelicula(String peliId) async {
    // este es url https://api.themoviedb.org/3/movie/419704/credits?api_key=65decc06132b29f2ddb36bfbdb83276b

    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key': _apikey,
      'language': _lenguaje,
    });

    final respuesta = await http.get(url);
    print(respuesta);
    final decodificadorDataDelMapa = json.decode(respuesta.body);

    // crear una nueva insancia del modelo cast
    final cast = new Cast.fromJsonList(decodificadorDataDelMapa['cast']);

    return cast.actores;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    // search/movie
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apikey,
      'language': _lenguaje,
      'query': query,
    });

    final ver = await _procesarRespuesta(url);
    print(ver);

    return ver;
  }
}
