import 'package:flutter/material.dart';
import 'package:peliculas/src/pag/inicio_pagina.dart';
import 'package:peliculas/src/pag/pelicula_detalle.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas App',
      initialRoute: '/',
      routes: {
        '/' :(BuildContext context) => InicioPagina(),
        'detalle': (BuildContext context) => PeliculaDetalle(),

      },
     
     
    );
  }
}
