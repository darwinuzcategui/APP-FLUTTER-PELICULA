import 'package:flutter/material.dart';

import '../preferencia/preferencia_usuarios.dart';

class AcercaPagina extends StatelessWidget {
  static final String routerName = 'acerca';
  final prefs = new PreferenciaUsuarios();

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagVisitada = AcercaPagina.routerName;
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: const Text('Acerca..'),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              //icon: const Icon(Icons.barcode_reader),
              tooltip: 'Regresar inicio',
              onPressed: () {
                //(InicioPagina.routerName != null)
                Navigator.pushReplacementNamed(context, "inicio");
                //: Navigator.pop(context);
              },
            ),
          ],
        ),
        body: ListView(
          children: <Widget>[
            miCard(context),
            miCardImage(),
            _botonesFlotante(context),
            miCardDesign(),
            miCardImageCarga(),
          ],
        ));
  }

  Card miCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.all(8),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('Escanear Barcode'),
            subtitle: Text(
                'Este es una applicación para consultar precio de la Base Datos D3XD . Aqui podemos ver la información de los productos de la base datos. La cual se visualiza toda la información de los item'),
            leading: Icon(Icons.barcode_reader),
          ),
        ],
      ),
    );
  }

  Card miCardImage() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(15),
      elevation: 10,
      child: Column(
        children: <Widget>[
          Image(
            image: NetworkImage(
                "https://img.freepik.com/fotos-premium/manos-mujer-joven-escaner-escanear-productos-cliente-gran-centro-comercial_310913-84.jpg?w=826"),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text('App GMD'),
          ),
        ],
      ),
    );
  }

  Card miCardImageCarga() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(15),
      elevation: 10,
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage(
                'https://darwinuzcategui1973.github.io/miPaginaWeb/imagenes/gmdpto.png'),
            placeholder: AssetImage('assets/img/loading0.gif'),
            fit: BoxFit.cover,
            height: 260,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text('Email: darwin.uzcategui1973@gmail.com '),
          )
        ],
      ),
    );
  }

  Card miCardDesign() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(15),
      elevation: 10,
      color: Color(0xFFE6EE9C),
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('Programador'),
            subtitle: Text('Darwin Felipe Uzcategui. Telefono 0414.921.32.35.'),
            leading: Icon(Icons.auto_graph_sharp),
          ),
        ],
      ),
    );
  }
}

Widget _botonesFlotante(BuildContext context) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //const Text('Extended'),
            //const SizedBox(height: 16),
            // An example of the extended floating action button.
            //
            // https://m3.material.io/components/extended-fab/specs#686cb8af-87c9-48e8-a3e1-db9da6f6c69b
            FloatingActionButton.extended(
              onPressed: () {
                // Add your onPressed code here!
                Navigator.pushReplacementNamed(context, "inicio");
              },
              label: const Text('Inicio'),
              icon: const Icon(Icons.home),
            ),
            //SizedBox( height: 28,),
          ],
        ),
      ],
    ),
  );
}
