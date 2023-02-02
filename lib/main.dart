import 'package:flutter/material.dart';
import 'package:productos/scan/scanearCodigo.dart';
import '../pag/inicio_pagina.dart';
import '../pag/producto_detalle.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => InicioPagina(),
        'detalle': (BuildContext context) => ProductoDetalle(),
        "scan":(BuildContext context) => ScanearCodigo(),
      },
    );
  }
}
