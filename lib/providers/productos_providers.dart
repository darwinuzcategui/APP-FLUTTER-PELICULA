import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;

import '../models/productos_model.dart';
import '../preferencia/preferencia_usuarios.dart';

class ProductosProvider {
  final prefs = new PreferenciaUsuarios();

  String get _url => prefs.urlbase.toString(); // '192.168.1.3:8080';
  //String _url = 'api.themoviedb.org';
  //String _url = _url1; //'192.168.1.3:3550';
  //String _lenguaje = 'es-ES';
  // ignore: unused_field
  int _paginaEnProductos = 0;

  bool _cargando = false;
  //print(_url);

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
    var productos = new Productos.fromJsonList([]);

    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final datosDecodificados = json.decode(resp.body);
      //final productos = new Productos.fromJsonList([]);
      // final productos = new Productos.fromJsonList(datosDecodificados);
      productos = new Productos.fromJsonList(datosDecodificados);

      //print("------------------------------");
      //print(productos.items.length);
      //print("------------------------------");
      //return productos.items;
    } else {
      print('FALLO CON EL ESTATUS: ${resp.statusCode}.');
      return [];
    }

    return productos.items;
  }

// Vamos a los llamados de enpoind

  Future<List<Producto>> getProductosDeD3xd() {
    print("getProductosDeD3xd() " + _url);
    final url = Uri.http(_url, '/d3xd/productos');

    print(url);

    return _procesarRespuesta(url);
  }

  Future<List<Producto>> getProductos() async {
    print('aqui el url : $_url');
    if (_cargando) {
      //print('getProductos $_paginaEnProductos');
      return [];
    } else {
      _cargando = true;
    }

    _paginaEnProductos++;
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

  Future<List<Producto>> getProducto(String codigoBarra) async {
    final url = Uri.http(_url, '/d3xd/barcode', {
      //'api_key': _apikey,
      //'language': _lenguaje,
      'buscar': codigoBarra,
    });

    final respuesta = await _procesarRespuesta(url);

    _gmdAppListaProductos.addAll(respuesta);

    // aqui utilizamos nuestros stream
    gmdAppListaProductosSink(_gmdAppListaProductos);

    _cargando = false;

    return respuesta;

    //return ver;
  }

  Future<String> grbarCodigoDeBarraEnD3xdProductoas(
      String codigoProducto, String codigoBarra) async {
    //{"id": "0001234","codBarra": "aI216072806399"}
    final codigoDeBarra = {'id': codigoProducto, 'codBarra': codigoBarra};
    print("*************************************");
    print(_url);
    print(codigoDeBarra);
    print("*************************************");

    final url = Uri.http(
      _url,
      '/d3xd/barcode',
    );
    //final resp = await http.post(url, body: json.encode(codigoDeBarra));
    var resp = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(codigoDeBarra));

    if (resp.statusCode == 200) {
      return "Se Guardo el código de Barra Satisfactoriamente!. ";
    }
    if (resp.statusCode == 301) {
      /*
      var url = Uri.https('example.com', 'whatsit/create');
var response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
print('Response status: ${response.statusCode}');
print('Response body: ${response.body}');

print(await http.read(Uri.https('example.com', 'foobar.txt')));
      */

      final url = Uri.https(
        _url,
        '/d3xd/barcode',
      );

      resp = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(codigoDeBarra));

      // return "Se Guardo el código de Barra Satisfactoriamente!. ";
    }

    //final resp = await http.post(url, headers: {"Content-Type": "application/json"},body: jsonEncode(codigoDeBarra));
    print("*************************************");
    print(resp.statusCode);
    print(resp.body);
    print(url);
    print("*************************************");

    //print(resp.body.length);

    return resp.body.toString();
  }
}
