// Generated by https://quicktype.io

/*
ProductoModel productoModelFromJson(String str) =>
    ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());
*/

class Productos {
  List<Producto> items = [];
  //List<Producto> items = new List();

  Productos();

  Productos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final producto = new Producto.fromJsonMap(item);
      items.add(producto);
    }
  }
}
/*
pcode: "0001234",
preferencia: "AREF-CODIGO",
pdescribe: "ACarnes de Primera",
pdepartamento: "",
pventa1: 5.480000019073486,
pventa2: 6.91,
pventa3: 5.32,
pventa4: 0,
pventa5: 0,
pempaque: "1",
pmedida: "UNI",
pmedempaque: "N/A",
pexiste: 2,
pintercode: "CODIGODEBARRA",
Pdatevoid: "31/12/2019",
pmoneydif: 1,
ptasac: 18.8
*/

class Producto {
  String pcode; //  este una propieda de nosotros
  String preferencia;
  String pdescribe;
  String pdepartamento;
  double pventa1;
  double pventa2;
  double pventa3;
  double pventa4;
  double pventa5;
  String pempaque;
  String pmedida;
  String pmedempaque;
  double pexiste;
  String pintercode;
  int pmoneydif;
  double ptasac;

  Producto({
    this.pcode,
    this.preferencia,
    this.pdescribe,
    this.pdepartamento,
    this.pventa1,
    this.pventa2,
    this.pventa3,
    this.pventa4,
    this.pventa5,
    this.pempaque,
    this.pmedida,
    this.pmedempaque,
    this.pexiste,
    this.pintercode,
    this.pmoneydif,
    this.ptasac,
  });

  Producto.fromJsonMap(Map<String, dynamic> json) {
    pcode = json['pcode'];
    pdescribe = json['pdescribe'];
    preferencia = json['preferencia'];
    pdepartamento = json['pdepartamento'];
    pventa1 = json['pventa1'] / 1;
    pventa2 = json['pventa2'] / 1;
    pventa3 = json['pventa3'] / 1;
    pventa4 = json['pventa4'] / 1;
    pventa5 = json['pventa5'] / 1;
    pempaque = json['pempaque'];
    pmedida = json['pmedida'];
    pmedempaque = json['pmedempaque'];
    pexiste = json['pexiste'] / 1;
    pintercode = json['pdepartamento'];
    pmoneydif = json['pmoneydif'];
    ptasac = json['ptasac'] / 1;
  }

  String get valor => null;

  getImagen() {
    if (pdescribe == null) {
      return "https://gruposriojanos.com/wp-content/uploads/2019/10/no-imagen-110.jpg";
    } else {
      // print (posterPath);
      //return "https://image.tmdb.org/t/p/w500/$pdescribe";
      //
      //return "https://gruposriojanos.com/wp-content/uploads/2019/10/no-imagen-110.jpg";
      return "https://akrocard.com/wp-content/uploads/2016/06/EAN8.png";
    }
  }

  getFondoImagen() {
    if (preferencia == null) {
      return "https://gruposriojanos.com/wp-content/uploads/2019/10/no-imagen-110.jpg";
    } else {
      // print (posterPath);
      return "https://image.tmdb.org/t/p/w500/$pdescribe";
    }
  }
}
