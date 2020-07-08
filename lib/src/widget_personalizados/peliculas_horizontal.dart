import 'package:flutter/material.dart';
import 'package:peliculas/src/models/peliculas_model.dart';

class PeliculasHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina;

  PeliculasHorizontal(
      {@required this.peliculas, @required this.siguientePagina});

  final _paginaCtl = new PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _medidaPantalla = MediaQuery.of(context).size;

    _paginaCtl.addListener(() {
      if (_paginaCtl.position.pixels >=
          _paginaCtl.position.maxScrollExtent - 200) {
        print('cargas siguiente peliculas');
        siguientePagina();
      } else {
        print('...');
      }
    });

    return Container(
      height: _medidaPantalla.height * 0.25,
      child: PageView.builder(
        pageSnapping: false,
        controller: _paginaCtl,
        //children: _tarjetas(context),
        itemCount: peliculas.length,
        itemBuilder: (context, i) {
          return _unaTarjeta(context, peliculas[i]);
        },
      ),
      // PageView sirve para delizar Widget, contenedores, paginas, card, etc.
    );
  }

  Widget _unaTarjeta(BuildContext context, Pelicula pelicula) {

    pelicula.idUnico = '${pelicula.id}-porter';


    final peliculaTarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: pelicula.idUnico,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(pelicula.getImagen()),
                fit: BoxFit.cover,
                height: 150.0,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
    return GestureDetector(
      child: peliculaTarjeta,
      onTap: () {
        print('Pulsaste click aqui! el de la pelicula es Id ${pelicula.id}');
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
    );
  }

/*
  List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(pelicula.getImagen()),
                fit: BoxFit.cover,
                height: 150.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  }
  */
}
