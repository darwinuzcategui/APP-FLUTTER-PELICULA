import 'package:flutter/material.dart';
//import 'package:peliculas/models/actores_model.dart';
//import 'package:peliculas/models/productos_model.dart';
//import 'package:peliculas/providers/productos_providers.dart';

import '../models/productos_model.dart';

class ProductoDetalle extends StatelessWidget {
  // esta en una forma final Pelicula pelicula;

  // contructor PeliculaDetalle(this.pelicula);

  @override
  Widget build(BuildContext context) {
    final Producto producto = ModalRoute.of(context).settings.arguments;
    var pmoneydif = producto.pmoneydif;
    var moneda = (pmoneydif == 1)
        ? "\$."
        : (pmoneydif == 2)
            ? "Eur."
            : "Bs.";
    var precio1 ='Precio 1 $moneda${producto.pventa1.toStringAsFixed(2)}';
    var precio2 ='Precio 2 $moneda${producto.pventa2.toStringAsFixed(2)}';
    var precio3 ='Precio 3 $moneda${producto.pventa3.toStringAsFixed(2)}';
    var precio4 ='Precio 4 $moneda${producto.pventa4.toStringAsFixed(2)}';

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        _crearAppbar(producto),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              // SizedBox(height: 10.0),
              _campoFormulario(producto, 'Nombre: ${producto.pdescribe}'), //1
              //SizedBox(height: 1.0),
              _campoFormulario(producto, precio1), //1
              _campoFormulario(producto, precio2), //1
              _campoFormulario(producto, precio3), //1
              _campoFormulario(producto, precio4), //1
              _campoFormulario(producto, producto.pdepartamento), //1
              _campoFormulario(producto, producto.pempaque), //1
              _campoFormulario(producto, producto.pintercode), //1
              _posterTitulo(context, producto),
              SizedBox(height: 1.0),
              //   _crearCasting(producto),
            ],
          ),
        )
      ],
    ));
  }

  Widget _crearAppbar(Producto producto) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.orange,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          producto.pdescribe,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 18, 18, 15),
              fontSize: 16.0),
          textAlign: TextAlign.center,
        ),
        background: FadeInImage(
          //image: NetworkImage(producto.getFondoImagen()),
          image: NetworkImage(
              "https://img.freepik.com/fotos-premium/manos-mujer-joven-escaner-escanear-productos-cliente-gran-centro-comercial_310913-84.jpg?w=826"),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

/*

  Widget _crearAppbar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.orange,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getFondoImagen()),
          placeholder: AssetImage('assets/img/loading.gif'),
       // placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(microseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
  */

  Widget _posterTitulo(BuildContext context, Producto producto) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 0.5),
      child: Row(
        children: <Widget>[
          Hero(
            tag: producto.pcode,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(producto.getImagen()),
                height: 105.0,
                width: 105.0,
              ),
            ),
          ),

          // SizedBox(width: 20.0,),

          Flexible(
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /*
                Text(
                  pelicula.pdescribe,
                  style: Theme.of(context).textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  pelicula.preferencia,
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                
                Text(
                  producto.pcode.toString(),
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                */
                Column(
                  children: <Widget>[
                    Icon(Icons.barcode_reader),
                    Text(
                      producto.pcode.toString(),
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _campoFormulario(Producto producto, String valor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Text(
        valor,
        textAlign: TextAlign.justify,
      ),
    );
  }
/*
  Widget _crearCasting(Producto pelicula) {
    final peliProvider = new ProductosProvider();

    return FutureBuilder(
      future: peliProvider.getCastActoresDePelicula(pelicula.pcode.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _crearActoresPageView(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }


  Widget _crearActoresPageView(List<Actor> actores) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),
        itemCount: actores.length,
        itemBuilder: (context, i) => _unActorTarjeta(actores[i]),
      ),
    );
  }

  Widget _unActorTarjeta(Actor actor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(actor.getFoto()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
  */
}
