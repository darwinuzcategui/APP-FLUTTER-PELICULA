import 'package:flutter/material.dart';
import 'package:peliculas/src/Buscar/buscar_delegate.dart';
import 'package:peliculas/src/providers/peliculas_providers.dart';
import 'package:peliculas/src/widget_personalizados/card_swiper_widget.dart';
import 'package:peliculas/src/widget_personalizados/peliculas_horizontal.dart';

class InicioPagina extends StatelessWidget {
  // const InicoPagina({Key key}) : super(key: key);
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    // aqui cuando se ejecuta
    peliculasProvider.getPopulares();
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Peliculas en Cines'),
          backgroundColor: Colors.orangeAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context, 
                  delegate:BuscarDatos(),
                  query: '' );
              },
            ),
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _swiperTarjeta(),
              _footerOpiePag(context),
            ],
          ),
        ));
  }

  // van los nuevos metodos de la clases

  Widget _swiperTarjeta() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );

    // peliculasProvider.getEnCines();

    // return CardSwiper(peliculas:[1,2,3,4,5,6,7],
    // );
    //para probar se hace con un retornandoun container
    //return Container();
  }

  Widget _footerOpiePag(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text("Populares ...",
                style: Theme.of(context).textTheme.subhead),
          ),
          SizedBox(height: 5.0),
          //FutureBuilder( // con esto se ejecuta una sola vez
          //  future: peliculasProvider.getPopulares(),
          StreamBuilder(
            // esto es observarble que se ejecuta cada vez que cambie el stream
            stream: peliculasProvider.popularesListaPeliculaStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              // snapshot.data?.forEach((peli)=> print(peli.title));
              if (snapshot.hasData) {
                // print(snapshot.data);
                return PeliculasHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,
                  );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
