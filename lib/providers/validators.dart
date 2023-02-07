import 'dart:async';

class Validators {
  final validateUsername = StreamTransformer<String, String>.fromHandlers(
      handleData: (userNameQweb, sink) {
    Pattern pattern = r'^[a-z0-9_-]{3,15}$';
    RegExp regExp = new RegExp(pattern as String);
    if (regExp.hasMatch(userNameQweb)) {
      sink.add(userNameQweb);
    } else {
      sink.addError('UserName no es Correcto');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (passwordQweb, sink) {
    if (passwordQweb.length >= 6) {
      sink.add(passwordQweb);
    } else {
      sink.addError('Mas de 5 Caracteres Por Favor');
    }
  });

  final validateHttp = StreamTransformer<String, String>.fromHandlers(
      handleData: (httpQweb, sink) {
    //Pattern pattern =
    //  r'^(https|http)://[a-z0-9-_%]+((.|/)[a-z0-9-_%]+)*(.[a-z]{2,6})(?[a-z0-9-_%]+=[a-z0-9-_%]+(&[a-z0-9-_%]+=[a-z0-9-_%]+)*)?$';
    //Pattern pattern = r'^https?:\/\/[\w\-]+(\.[\w\-]+)+[/#?]?.*$';
    Pattern pattern = r'[\w\-]+(\.[\w\-]+)+[/#?]?.*$';
    RegExp regExp = new RegExp(pattern as String);
    if (regExp.hasMatch(httpQweb)) {
      sink.add(httpQweb);
    } else {
      sink.addError('Ruta Http o Https no es Correcta!');
    }
  });

  final validatePuerto = StreamTransformer<String, String>.fromHandlers(
      handleData: (puertoQweb, sink) {
    Pattern pattern =
        r'^(6553[0-5]|655[0-2][0-9]|65[0-4][0-9]{2}|6[0-4][0-9]{3}|[0-5]?([0-9]){0,3}[0-9])$';
    RegExp regExp = new RegExp(pattern as String);
    if (regExp.hasMatch(puertoQweb)) {
      sink.add(puertoQweb);
    } else {
      sink.addError(
          'Puerto no es Valido!.. Sólo acepta números comprendidos entre 0 y 65535');
    }
  });
}
