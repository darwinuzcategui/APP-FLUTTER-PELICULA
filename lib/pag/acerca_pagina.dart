import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../preferencia/preferencia_usuarios.dart';

class AcercaPagina extends StatelessWidget {
  static final String routerName = 'acerca';
  final prefs = new PreferenciaUsuarios();

  get child => null;

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
            miCardImage(context),
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
                'io de Este es una applicación para consultar precla Base Datos D3XD . Aqui podemos ver la información de los productos de la base datos. La cual se visualiza toda la información de los item'),
            leading: Icon(Icons.barcode_reader),
          ),
        ],
      ),
    );
  }

  Card miCardImage(BuildContext context) {
    final Uri urlmiPagina = Uri(
        scheme: 'https',
        host: 'darwinuzcategui1973.github.io',
        path: 'miPaginaWeb/');
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(15),
      elevation: 10,
      child: new InkWell(
        onTap: () {
          _lanzarEnWebVistaEnAPP(urlmiPagina);
        },
        child: Column(
          children: <Widget>[
            Image(
              image: NetworkImage(
                  "https://img.freepik.com/fotos-premium/manos-mujer-joven-escaner-escanear-productos-cliente-gran-centro-comercial_310913-84.jpg?w=826"),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text('Visitame --> mi PaginaWeb'),
            ),
          ],
        ),
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
            child: new InkWell(
              onTap: () {
                _emailPorTelefono("darwin envio soporte");
              },
              child: Text('Email: darwin.uzcategui1973@gmail.com '),
            ),
          ),
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
      child: new InkWell(
        onTap: () {
          _llamarPorTelefono("04149213235");
        },
        child: Column(
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
              title: Text('Programador'),
              subtitle:
                  Text('Darwin Felipe Uzcategui. Telefono 0414.921.32.35.'),
              leading: Icon(Icons.auto_graph_sharp),
            ),
          ],
        ),
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
                //_llamarPorTelefono("04149213235");
                // _mensajePorTelefono("04241882080");
                // _llamarPorTelefono("04149213235");

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

// Función que lanza el intento de llamada con la url: tel:<phone number>
Future<void> _llamarPorTelefono(String telefonoNumero) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: telefonoNumero,
  );
  await launchUrl(launchUri);
}

/*
Future<void> _mensajePorTelefono(String telefonoNumero) async {
  final Uri smsLaunchUri = Uri(
      scheme: 'sms',
      path: telefonoNumero,
      queryParameters: <String, String>{
        'body': Uri.encodeComponent('prebaunodostres'),
      });
  await launchUrl(smsLaunchUri);
}
*/
/*
 final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'smith@example.com',
    query: encodeQueryParameters(<String, String>{
      'subject': 'Example Subject & Symbols are allowed!',
    }),
  );

*/
Future<void> _emailPorTelefono(String email) async {
  String encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'darwin.uzcategui1973@gmail.com',
    query: encodeQueryParameters(<String, String>{
      'subject': 'Soporte Enviado por AppGMD',
      'body':
          'Soporte de enviado desde la Aplicación, Desde Mi Aplicativo GMD de Codigo de Barra ',
    }),
  );
  launchUrl(emailLaunchUri);
}

Future<void> _lanzarEnWebVistaEnAPP(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.inAppWebView,
    webViewConfiguration: const WebViewConfiguration(
        headers: <String, String>{'my_header_key': 'my_header_value'}),
  )) {
    throw Exception('Could not launch $url');
  }
}
