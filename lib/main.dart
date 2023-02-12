import 'package:flutter/material.dart';
import 'package:productos/pag/acerca_pagina.dart';
import 'package:productos/pag/configuracion_pagina.dart';
import 'package:productos/pag/prueba.dart';
import 'package:productos/providers/provider.dart';
import 'package:productos/scan/scanearCodigo.dart';
import '../pag/inicio_pagina.dart';
import '../pag/producto_detalle.dart';
import 'preferencia/preferencia_usuarios.dart';

//void main() => runApp(MyApp());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciaUsuarios();
  await prefs.initPrefs();
  runApp(MyApp());
}

//InicioPag.routerName: (BuildContext context) => InicioPag(),
class MyApp extends StatelessWidget {
  final prefs = new PreferenciaUsuarios();
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
   // return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: Color.fromARGB(255, 194, 131, 23),
          useMaterial3: true),
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      //initialRoute: '/',
      initialRoute: prefs.ultimaPagVisitada,
      routes: {
        InicioPagina.routerName: (BuildContext context) => InicioPagina(),
        ProductoDetalle.routerName: (BuildContext context) => ProductoDetalle(),
        ScanearCodigo.routerName: (BuildContext context) => ScanearCodigo(),
        AcercaPagina.routerName: (BuildContext context) => AcercaPagina(),
        Prueba.routerName: (BuildContext context) => Prueba(),
        ConfiguracionPagina.routerName: (BuildContext context) =>
            ConfiguracionPagina(),
        //darwin
        //},
        // '/': (BuildContext context) => InicioPagina(),
        // 'detalle': (BuildContext context) => ProductoDetalle(),
        // "scan": (BuildContext context) => ScanearCodigo(),
        // '/detalle23': (BuildContext context) => ProductoDetalle(),
      },
      ),
    );
  }
}
