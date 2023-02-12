import 'package:flutter/material.dart';
//import 'dart:async';

bool isNombreArchivoSinExtesion(String s) {
  if (s.isEmpty) return false;

  // Pattern pattern = r'^[a-z0-9_-]{3,30}$/i';
  ///^[a-z ,.'-]+$/i
  //^([a-zA-Z]{2,}\s[a-zA-z]{1,}'?-?[a-zA-Z]{2,}\s?([a-zA-Z]{1,})?)
  Pattern pattern = r'^[a-zA-Z0-9-_ ]{3,40}$';
  // r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern as String);

  //print("expresion regular " + s);
  //print(regExp.hasMatch(s));
  return (regExp.hasMatch(s)) ? true : false;
}

bool isEmailgmd(String s) {
  if (s.isEmpty) return false;

  // Pattern pattern = r'^[a-z0-9_-]{3,15}$';
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern as String);
  /*
    if (regExp.hasMatch(s)) {
      return true;
    } else {
      return false;
    }
    */

  return (regExp.hasMatch(s)) ? true : false;
}

bool isComentario(String s) {
  if (s.isEmpty) return false;

  // Pattern pattern = r'^[a-z0-9_-]{3,30}$/i';
  ///^[a-z ,.'-]+$/i
  //^([a-zA-Z]{2,}\s[a-zA-z]{1,}'?-?[a-zA-Z]{2,}\s?([a-zA-Z]{1,})?)
  Pattern pattern = r'^[a-zA-Z0-9-_ ]{5,100}$';
  // r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern as String);

  //print("expresion regular " + s);
  //print(regExp.hasMatch(s));
  return (regExp.hasMatch(s)) ? true : false;
}

void showAlertgmd(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Información"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("Ok"),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      });
}
