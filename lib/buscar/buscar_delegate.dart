import 'package:flutter/material.dart';
import 'package:peliculas/models/peliculas_model.dart';
import 'package:peliculas/providers/peliculas_providers.dart';

class BuscarDatos extends SearchDelegate {

  String seleccion;

  final peliculasProvider = new PeliculasProvider();


  final peliculas= [
    'Jordan',
    'Superman',
    'Batman',
    'Gordar',
    'Jordan Volador',
    'Superman 2',
    'Superman 3',
    'Superman 4',
    'Aquam  de Papel'
  ];

  final peliculasRecientes = [
    'Superman',
    'Guason',
    'Aquaman'
    
  ];



  @override
  List<Widget> buildActions(BuildContext context) {
    // la acciones de nuestros app
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          print('click !!!');
          query='';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icono a las izquirda appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        print('Leading Icons Press ');
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // la intruccion que crear losresultadosa mostra
    return Center(
      child:Container(
        height: 100.0,
        width: 100.0,
        color:Colors.orangeAccent,
        child: Text(seleccion),
      ),
      );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Es la sugerencias que aparece cuando se ecribe.

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        
        if( snapshot.hasData ) {

          final peliculas = snapshot.data;


          return ListView(
            children:peliculas.map((pelicula){
              return ListTile(
                leading: FadeInImage(
                  // assets/img/no-image.jpg
                  placeholder: AssetImage('assets/img/no-image.jpg'), 
                  image: NetworkImage(pelicula.getImagen()),
                  width:50.0,
                  fit: BoxFit.contain,

                  ),
                  title: Text(pelicula.title),
                  subtitle: Text(pelicula.originalTitle),
                  onTap: (){
                    print('pulsaste aqui');
                    //primero cerramos la busqueda
                    close(context, null);
                    pelicula.idUnico='';
                    Navigator.pushNamed(context,'detalle',arguments: pelicula);

                  },
                  
                  
              );
            }).toList()
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
       
      },
    );

   
  }


//  @override
//   Widget buildSuggestions(BuildContext context) {
//     // es la sugrecia de cuando se ecribe

//     final listaSugerida = (query.isEmpty)
//                             ? peliculasRecientes
//                             :peliculas.where(
//                               (p)=>p.toLowerCase().startsWith(query.toLowerCase()) // quiere decir que retorna una lista de lo que se escribio es query
//                               ).toList();
//     return ListView.builder(
//       itemCount: listaSugerida.length,
//       itemBuilder: (context,i){
//         return ListTile(
//           leading: Icon(Icons.movie),
//           title: Text(listaSugerida[i]),
//           onTap: (){
//             seleccion = listaSugerida[i];
//             showResults(context);
//           },


//         );

//       },

//     );
//   }



}


