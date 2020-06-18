class Cast {

  List<Actor> actores = new List();
  
  Cast.deListaAJsonlista(List<dynamic> jsonLista){
    if (jsonLista == null ) return;

    jsonLista.forEach( (item){
      final actor =  Actor.deMapaAjson(item);
      actores.add(actor);
    });


  }


}



class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor ({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.deMapaAjson(Map<String, dynamic> json ){

      castId      = json['cast_id'];
      character   = json['character'];
      creditId    = json['credit_id'];
      gender      = json['gender'];
      id          = json['id'];
      name        = json['name'];
      order       = json['order'];
      profilePath = json['profile_path'];


  }
  
  getFoto() {
    if (profilePath == null) {
     
      return "https://i0.pngocean.com/files/778/849/85/computer-icons-user-login-avatar-clip-art-small-icons.jpg";
    } else {
      // print (posterPath);
      return "https://image.tmdb.org/t/p/w500/$profilePath";
    }
  }

}