import 'dart:io';

import 'package:flutter_tesisv2/src/productos/acciones/detalle_producto.dart';
import 'package:flutter_tesisv2/src/usuarios/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Productos extends StatefulWidget {
  static const String ROUTE = "/productos";

  @override
  _ProductosState createState() => _ProductosState();
}

class _ProductosState extends State<Productos> {
  List data = [];
  var f;
  List dataProd = [];
  String dropdownValue;
  TextEditingController filtron = TextEditingController();
  @override
  void initState() {
    verCategoria().then((value) {
      data = value;

      setState(() {});
    });

    verProductos().then((value) {
      dataProd = value;
      setState(() {});
    });

    super.initState();
  }

  Future<List> verProductos() async {
    var url = "http://152.173.207.169/pruebastesis/obtenerProducto.php";
    final response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  }

  Future verCategoria() async {
    var url = "http://152.173.207.169/pruebastesis/verCategorias.php";
    final response = await http.get(Uri.parse(url));
    final dataJson = jsonDecode(response.body);
    return dataJson;
  }

  Future<List> filtroCategoria() async {
    var url =
        "http://152.173.207.169/pruebastesis/filtroCategorias.php?Categoria_id=$dropdownValue";
    final response = await http.get(Uri.parse(url));
    final dataFiltro = jsonDecode(response.body);
    return dataFiltro;
  }

  Future filtroNombre() async {
    f = filtron.text;
    var url =
        "http://152.173.207.169/pruebastesis/filtroNombre.php?Producto_nombre=$f";
    final response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 165, 207, 1),
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 131, 163, 1),
        title: TextField(
          controller: filtron,
          decoration: InputDecoration(hintText: "buscar producto"),
          onEditingComplete: () {},
        ),
        actions: [
          IconButton(
              onPressed: () {
                if (f != "") {
                  filtroNombre().then((value) {
                    dataProd = value;
                    setState(() {});
                  });
                } else {}
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DropdownButton<String>(
                    hint: Text("seleccione una categoria"),
                    value: dropdownValue,
                    underline: Container(
                      height: MediaQuery.of(context).size.height,
                    ),
                    onChanged: (String newvalue) {
                      dropdownValue = newvalue;
                      if (dropdownValue == null) {
                      } else {
                        filtroCategoria().then((value) {
                          dataProd = value;
                          setState(() {});
                        });
                      }
                    },
                    items: data.map<DropdownMenuItem<String>>(
                      (value) {
                        return DropdownMenuItem<String>(
                          value: value["Categoria_id"],
                          child: Text(value["Categoria_nombre"]),
                        );
                      },
                    ).toList(),
                  ),
                  FlatButton(
                    color: Colors.white,
                    onPressed: () {
                      dropdownValue = null;
                      verProductos().then((value) {
                        dataProd = value;
                        setState(() {});
                      });
                    },
                    child: Text(
                      "quitar filtro",
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Divider()
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: PageScrollPhysics(),
                itemCount: dataProd.length,
                itemBuilder: (context, index) {
                  var imagenprod = dataProd[index]['Producto_foto'];
                  int precio = int.parse(dataProd[index]['Producto_precio']);
                  String preciof = NumberFormat("#,###")
                      .format(precio)
                      .toString()
                      .replaceAll(",", ".");
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => DetallesProducto(
                          index: index,
                          lista: dataProd,
                        ),
                      ));
                    },
                    child: Card(
                      margin: EdgeInsets.all(10),
                      color: Color.fromRGBO(240, 248, 255, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 25.0,
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            child: dataProd[index]['Producto_foto'] != null ||
                                    dataProd[index]['Producto_foto'] == ""
                                ? FadeInImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        "http://152.173.207.169/lefufuapp/public/uploads/kits/$imagenprod"),
                                    placeholder:
                                        AssetImage('assets/jar-loading.gif'),
                                  )
                                : Image.asset(
                                    "assets/no-image.png",
                                    fit: BoxFit.fill,
                                  ),
                          ),
                          Text(
                            dataProd[index]['Producto_nombre'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          Divider(),
                          Text(
                            "Precio: \$" + preciof,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
