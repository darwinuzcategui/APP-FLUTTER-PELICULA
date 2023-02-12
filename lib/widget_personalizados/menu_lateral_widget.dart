import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productos/pag/inicio_pagina.dart';
import 'package:productos/scan/scanearCodigo.dart';

import '../pag/acerca_pagina.dart';
import '../pag/configuracion_pagina.dart';
//import '../pag/prueba.dart';
//import 'package:productos/pag/producto_detalle.dart';
//import 'package:productos/pag/inicio_pagina.dart';
//import 'package:prefrenciausuarioapp/src/pag/inicio_pag.dart';
///import 'package:prefrenciausuarioapp/src/pag/settings_pag.dart';

class MenuWidgetDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const rowColor1 = Color.fromRGBO(51, 102, 255, 1);
    const rowColor2 = Color.fromRGBO(102, 102, 255, 1);
    const rowColor3 = Color.fromRGBO(153, 102, 255, 1);
    const rowColor4 = Color.fromRGBO(204, 51, 255, 1);
    const rowColor5 = Color.fromARGB(255, 194, 131, 23);
    //final theme = Theme.of(context);
    //final textTheme = theme.textTheme;
    //style: textTheme.bodyLarge,

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img/img2.jpg'),
                    fit: BoxFit.fill)),
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            leading: Icon(Icons.pages, color: rowColor1),
            title: Text('Lista de Producto'),
            onTap: () => Navigator.pushReplacementNamed(
                context, InicioPagina.routerName),
          ),
          ListTile(
            leading: Icon(Icons.barcode_reader, color: rowColor2),
            title: Text('Scanear Codigo de Barra'),
            onTap: () => Navigator.pushReplacementNamed(
                context, ScanearCodigo.routerName),
          ),
          ListTile(
            leading: Icon(Icons.abc_outlined, color: rowColor3),
            title: Text('Acerca de La App'),
            onTap: () => Navigator.pushReplacementNamed(
                context, AcercaPagina.routerName),
          ),
          /*ListTile(
            leading: Icon(Icons.accessibility_rounded, color: rowColor5),
            title: Text('Prueba'),
            onTap: () =>
                Navigator.pushReplacementNamed(context, Prueba.routerName),
          ),
          */
          ListTile(
              leading: Icon(Icons.settings, color: Colors.amber),
              title: Text('Ajuste'),
              onTap: () {
                // ConfiguracionPagina
                // Navigator.pop(context); // para cerrar el menu
                // Navigator.pushNamed(context, SettingPag.routerName);
                Navigator.pushReplacementNamed(
                    context, ConfiguracionPagina.routerName);
              }),
          ListTile(
              leading: Icon(Icons.close_fullscreen_sharp, color: rowColor4),
              title: Text('Cerrar Menu'),
              onTap: () {
                Navigator.pop(context); // para cerrar el menu
                // Navigator.pushNamed(context, SettingPag.routerName);
                //Navigator.pushReplacementNamed(context, SettingPag.routerName);
              }),
          ListTile(
            leading: Icon(Icons.close, color: rowColor5),
            title: Text('Salir de la APP'),
            onTap: () {
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                exit(0);
              }
            },
          ),
        ],
      ),
    );
  }
}
