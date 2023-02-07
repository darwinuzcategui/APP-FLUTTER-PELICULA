import 'dart:async';

import 'package:productos/providers/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  //final _userNamegmdController = BehaviorSubject<String>();
  //final _passwordgmdController = BehaviorSubject<String>();

  final _httpgmdController = BehaviorSubject<String>();
  final _puertogmdController = BehaviorSubject<String>();

  // Recuperar los datos del Stream o flujo de informacion
  //Stream<String> get userNamegmdStream =>
  //   _userNamegmdController.stream.transform(validateUsername);
  //Stream<String> get passwordgmdStream =>
  //    _passwordgmdController.stream.transform(validatePassword);

  Stream<String> get httpgmdStream =>
      _httpgmdController.stream.transform(validateHttp);

  Stream<String> get puertogmdStream =>
      _puertogmdController.stream.transform(validatePuerto);

  //Stream<bool> get formValidStream => Rx.combineLatest2(
  //   userNamegmdStream, passwordgmdStream, (dynamic a, dynamic b) => true);

  Stream<bool> get formValidStream1 => Rx.combineLatest2(
      httpgmdStream, puertogmdStream, (dynamic a, dynamic b) => true);

  // Inserto Valor al Stream
  // getter
  //Function(String) get changeUserNamegmd => _userNamegmdController.sink.add;
  //Function(String) get changePasswordgmd => _passwordgmdController.sink.add;
  Function(String) get changeHttpgmd => _httpgmdController.sink.add;
  Function(String) get changePuertogmd => _puertogmdController.sink.add;

  // obtener el ultimo valor ingresado a los streams

  //String get userNamegmd => _userNamegmdController.value.toLowerCase();
  //String get passwordQwb => _passwordgmdController.value;
  String get httpQwb => _httpgmdController.value;
  String get puertoQwb => _puertogmdController.value;

  dispose() {
    //_userNamegmdController.close();
    //_passwordgmdController.close();
    _httpgmdController.close();
    _puertogmdController.close();
  }
}
