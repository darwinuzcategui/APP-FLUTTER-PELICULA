import 'package:flutter/material.dart';

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text("APP Scanear"),
            accountEmail: Text("darwin.uzcategui1973es@gmail.com"),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://img.freepik.com/fotos-premium/manos-mujer-joven-escaner-escanear-productos-cliente-gran-centro-comercial_310913-84.jpg?w=826"),
                    fit: BoxFit.cover)),
          ),
          Ink(
            color: Colors.amberAccent,
            child: new ListTile(
              title: Text(
                "MENU 1",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          new ListTile(
            title: Text("MENU 2"),
            onTap: () {},
          ),
          new ListTile(
            title: Text("MENU 3"),
          ),
          new ListTile(
            title: Text("MENU 4"),
          )
        ],
      ),
    );
  }
}
