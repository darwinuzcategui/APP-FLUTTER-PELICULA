import 'package:flutter/material.dart';
import 'package:productos/scan/scanearCodigo.dart';
import '../pag/inicio_pagina.dart';
import '../pag/producto_detalle.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: Color.fromARGB(255, 194, 131, 23),
          useMaterial3: true),
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => InicioPagina(),
        'detalle': (BuildContext context) => ProductoDetalle(),
        "scan": (BuildContext context) => ScanearCodigo(),
        '/detalle23': (BuildContext context) => ProductoDetalle(),
      },
    );
  }
}
