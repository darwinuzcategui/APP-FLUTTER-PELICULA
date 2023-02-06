// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;

import '../models/productos_model.dart';

class ProductosProvider {
  //String _apikey = '65decc06132b29f2ddb36bfbdb83276b';
  //String _url = 'api.themoviedb.org';
  String _url = '192.168.1.3:3550';
  //String _lenguaje = 'es-ES';
  int _paginaEnProductos = 0;

  bool _cargando = false;

  // vamos hacer las definicion
  List<Producto> _gmdAppListaProductos = [];
  // este es codigo para crear un Stream el broasdcast para que varias personas escuches o varios subscriptores
  // este la tuberia solamente
  final _gmdAppListaProductostreamController =
      StreamController<List<Producto>>.broadcast();

  // con esto introducidos la Productos o cualquire cosa esta la sixtaxis
  Function(List<Producto>) get gmdAppListaProductosSink =>
      _gmdAppListaProductostreamController.sink.add;
  //_popi

  //para escuchar las Productos es con Stream y se le puede decir es tipo de informacion que esta emitiendo<List<Pelota>>
  Stream<List<Producto>> get gmdAppListaProductostream =>
      _gmdAppListaProductostreamController.stream;

  void disposeStreams() {
    _gmdAppListaProductostreamController?.close();
  }

  // vamos hacer un metodo de esta clases privados para optimizar el codigo

  Future<List<Producto>> _procesarRespuesta(Uri url) async {
    /*
    var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var itemCount = jsonResponse['totalItems'];
    print('Number of books about http: $itemCount.');
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}
    */
    var productos = new Productos.fromJsonList([]);

    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final datosDecodificados = json.decode(resp.body);
      //final productos = new Productos.fromJsonList([]);
      // final productos = new Productos.fromJsonList(datosDecodificados);
      productos = new Productos.fromJsonList(datosDecodificados);

      print("------------------------------");
      print(productos.items.length);
      print("------------------------------");
      //return productos.items;
    } else {
      print('FALLO CON EL ESTATUS: ${resp.statusCode}.');
      return [];
    }

    return productos.items;
  }

// Vamos a los llamados de enpoind

  Future<List<Producto>> getProductosDeD3xd() {
    final url = Uri.http(_url, '/d3xd/productos');

    print(url);

    return _procesarRespuesta(url);
  }

  Future<List<Producto>> getProductos() async {
    print('aqui el url : $_url');
    if (_cargando) {
      print('getProductos $_paginaEnProductos');
      return [];
    } else {
      _cargando = true;
    }

    _paginaEnProductos++;
    // print('getgmdApp $_paginaEngmdApp');
    //final url = Uri.https(_url, '3/movie/popular', {
    //final url1 = Uri.http(_url);

    //final url = Uri.http(_url, '', {
    //  'api_key': _apikey,
    //  'language': _lenguaje,
    //  'page': _paginaEngmdApp.toString(),
    // });
    /*
    final _url = "example.com/api/";
final _uri = Uri.https(path: _url, queryParameters: _params);
    */
    //var uri = Uri.http(_url, '/productos', {'q': 'dart'});
    var uri = Uri.http(_url, '/productos');
    print(uri); // http://example.org/path?q=dart

    //uri = Uri.http('user:password@localhost:8080', '');
    //print(uri); // http://user:password@localhost:8080

    //uri = Uri.http('example.org', 'a b');
    //print(uri); // http://example.org/a%20b

    //uri = Uri.http('example.org', '/a%2F');
    //print(uri); // http://example.org/a%252F
//The scheme is always set to http.

//The userInfo, host and port components are set from the [authority] argument. If authority is null or empty, the created Uri has no authority, and isn't directly usable as an HTTP URL, which must have a non-empty host.

//The path component is set from the [unencodedPath] argument. The path passed must not be encoded as this constructor encodes the path. Only / is recognized as path separtor. If omitted, the path defaults to being empty.

//The query component is set from the optional [queryParameters] argument.

    //final url = Uri.http(_url, "/productos");
    var url = Uri.http(_url, '/d3xd/productos');
    print('la url full : $url');

    final respuesta = await _procesarRespuesta(url);

    _gmdAppListaProductos.addAll(respuesta);

    // aqui utilizamos nuestros stream
    gmdAppListaProductosSink(_gmdAppListaProductos);

    _cargando = false;

    return respuesta;
  }

  Future<List<Producto>> buscarD3xdProductos(String terminoABuscar) async {
    // search/movie
    final url = Uri.http(_url, '/d3xd/buscar', {
      //'api_key': _apikey,
      //'language': _lenguaje,
      'buscar': terminoABuscar,
    });

    final ver = await _procesarRespuesta(url);
    print(ver);

    return ver;
  }

  Future<List<Producto>> GetProducto(String codigoBarra) async {
    // search/movie
    //print("**************" + codigoBarra);
    final url = Uri.http(_url, '/d3xd/barcode', {
      //'api_key': _apikey,
      //'language': _lenguaje,
      'buscar': codigoBarra,
    });

    //final ver = await _procesarRespuesta(url);
    //print("*******GetProducto***********************" + codigoBarra);
    // print(ver);
    // print(ver.length);
    //print("***************************************");

    final respuesta = await _procesarRespuesta(url);

    _gmdAppListaProductos.addAll(respuesta);

    // aqui utilizamos nuestros stream
    gmdAppListaProductosSink(_gmdAppListaProductos);

    _cargando = false;

    return respuesta;

    //return ver;
  }
}
