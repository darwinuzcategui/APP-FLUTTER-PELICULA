import 'package:flutter/material.dart';

import '../preferencia/preferencia_usuarios.dart';
import '../providers/productos_providers.dart';
import '../providers/provider.dart';
import '../utilis/utilis.dart' as util;

class ConfiguracionPagina extends StatefulWidget {
  @override
  State<ConfiguracionPagina> createState() => _ConfiguracionPaginaState();
  static final String routerName = 'configuracion';
}

class _ConfiguracionPaginaState extends State<ConfiguracionPagina> {
  final productosProvider = new ProductosProvider();

  //final prefs = new PreferenciaUsuarios();

  var prefs = new PreferenciaUsuarios();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _registerForm(context),
        ],
      ),
    );
  }

  Widget _registerForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
              child: Container(
            height: 190.0,
          )),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black38,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text('Conexion GMD', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 10.0),
                _crearHttp(bloc),
                SizedBox(height: 10.0),
                _crearPuerto(bloc),
                SizedBox(height: 15.0),
                _crearBoton(bloc),
              ],
            ),
          ),
          TextButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, 'inicio'),
              child: Text('Ya tienes una Conexion registrada ?')),
          SizedBox(height: 25.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color.fromARGB(255, 242, 97, 61),
                          Color.fromARGB(255, 239, 168, 87),
                          Colors.orange,
                          Color.fromARGB(179, 225, 207, 10),
                        ],
                      ),
                    ),
                  ),
                ),
                TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Color.fromARGB(255, 13, 12, 12),
                      padding: const EdgeInsets.all(16.0),
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    onPressed: () => {
                          prefs.urlbase = 'backen-producto-production.up.railway.app',
                          Navigator.pushReplacementNamed(context, 'inicio'),
                        },
                    //prefs.urlbase = "",
                    //print(prefs.urlbase);

                    child: Text('En modo DEMO---> Backend en la nube ?')),
                SizedBox(height: 50.0)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _crearHttp(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.httpgmdStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                icon: Icon(Icons.http, color: Colors.blue.shade300),
                hintText: 'Ejm 192.168.1.3',
                labelText: 'Ruta de GMD ',
                counterText: snapshot.data,
                errorText: snapshot.error as String),
            //onChanged:(value)=>bloc.changeUserNamegmd(value),
            onChanged: bloc.changeHttpgmd,
          ),
        );
      },
    );
  }

  Widget _crearPuerto(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.puertogmdStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                icon: Icon(Icons.pin_outlined, color: Colors.blue.shade300),
                hintText: 'Ejm 8080',
                labelText: 'Puerto GMD',
                counterText: snapshot.data,
                errorText: snapshot.error as String),
            onChanged: bloc.changePuertogmd,
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      foregroundColor: Colors.orange,
      elevation: 0.0,
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
    );

    return StreamBuilder(
      stream: bloc.formValidStream1,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextButton(
          style: flatButtonStyle,
          onPressed: snapshot.hasData ? () => _register(bloc, context) : null,
          child: Text("Crear"),
        );
      },
    );
  }

  _register(LoginBloc bloc, BuildContext context) async {
    print('===========================');
    print('http: ${bloc.httpQwb} ');
    print('Puerto: ${bloc.puertoQwb} ');
    print('===========================');
    String _http = bloc.httpQwb.toString();
    String _puerto = bloc.puertoQwb.toString();
    //prefs.ultimaPagVisitada = AcercaPagina.routerName;
    //prefs.urlbase = '${bloc.httpQwb}:${bloc.puertoQwb}';
    prefs.urlbase = _http + ":" + _puerto;
    print(prefs.urlbase);

    //final info = await .nuevoUsuario(bloc.email, bloc.clave);

    // ignore: unnecessary_null_comparison
    if (bloc.httpQwb == null) {
      //shshowAlertgmd
      util.showAlertgmd(context, "no Puede ser nula o vacia ruta");
    } else {
      //final info = "ok";
      Navigator.pushReplacementNamed(context, 'inicio');
    }

/*
    if (info['ok']) {
      Navigator.pushReplacementNamed(context, 'inicio');
    } else {
      util.showAlertgmd(context, info['mensaje']);
    }
*/
    // Navigator.pushReplacementNamed(context, 'inicio');
  }

  Widget _crearFondo(BuildContext context) {
    prefs.ultimaPagVisitada = ConfiguracionPagina.routerName;
    final size = MediaQuery.of(context).size;
    final backgroundgmd = Container(
      height: size.height * 0.40,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromARGB(255, 242, 97, 61),
        Color.fromARGB(255, 239, 168, 87)
      ])),
    );
    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: Color.fromARGB(10, 13, 10, 99)),
    );

    return Stack(
      children: <Widget>[
        backgroundgmd,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.account_tree, color: Colors.white, size: 100.0),
              SizedBox(
                height: 10.0,
                width: double.infinity,
              ),
              Text('GMD-App',
                  style: TextStyle(color: Colors.white, fontSize: 30.0)),
            ],
          ),
        )
      ],
    );
  }
}
