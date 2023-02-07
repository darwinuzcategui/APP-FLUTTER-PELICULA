import 'package:shared_preferences/shared_preferences.dart';

class PreferenciaUsuarios {
  static final PreferenciaUsuarios _instancia =
      new PreferenciaUsuarios._internal();

  factory PreferenciaUsuarios() {
    return _instancia;
  }

  PreferenciaUsuarios._internal();

  SharedPreferences _prefs; // va esta inicializadas todas las preferencias

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // no se van usuar esta propiedades
  // bool _colorSecundario;
  // int _genero;
  // String _nombre;

  //GET Y SET del Genero

  get genero {
    return _prefs.getInt('genero') ?? 1;
  }

  set genero(int valor) {
    _prefs.setInt('genero', valor);
  }

  //GET Y SET de ColorSecundario

  get colorSecundario {
    return _prefs.getBool('colorSecundario') ?? false;
  }

  set colorSecundario(bool valor) {
    _prefs.setBool('colorSecundario', valor);
  }

  //GET Y SET de nombreUsuario
  get nombreUsuario {
    return _prefs.getString('nombreUsuario') ?? '';
  }

  set nombreUsuario(String valor) {
    _prefs.setString('nombreUsuario', valor);
  }

  //GET Y SET de Ultima Pag
  get ultimaPagVisitada {
    return _prefs.getString('ultimaPagVisitada') ?? 'inicio';
  }

  set ultimaPagVisitada(String valor) {
    _prefs.setString('ultimaPagVisitada', valor);
  }

  // GET y SET del urlBase
  String get urlbase {
    return _prefs.getString('urlbase') ?? '192.168.1.3:8080';
  }

  set urlbase(String value) {
    _prefs.setString('urlbase', value);
  }
}
