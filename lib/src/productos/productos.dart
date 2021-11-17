import 'dart:io';

import 'package:flutter_tesisv2/src/productos/acciones/detalle_producto.dart';
import 'package:flutter_tesisv2/src/usuarios/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:image_picker/image_picker.dart';

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
    var url = "http://192.168.1.81/pruebastesis/obtenerProducto.php";
    final response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  }

  Future verCategoria() async {
    var url = "http://192.168.1.81/pruebastesis/verCategorias.php";
    final response = await http.get(Uri.parse(url));
    final dataJson = jsonDecode(response.body);
    return dataJson;
  }

  Future<List> filtroCategoria() async {
    var url =
        "http://192.168.1.81/pruebastesis/filtroCategorias.php?Categoria_id=$dropdownValue";
    final response = await http.get(Uri.parse(url));
    final dataFiltro = jsonDecode(response.body);
    return dataFiltro;
  }

  Future filtroNombre() async {
    f = filtron.text;
    var url =
        "http://192.168.1.81/pruebastesis/filtroNombre.php?Producto_nombre=$f";
    final response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
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
                      if (dropdownValue == 0) {
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
                  ElevatedButton(
                      onPressed: () {
                        dropdownValue == 0;
                        verProductos().then((value) {
                          dataProd = value;
                          setState(() {});
                        });
                      },
                      child: Text("quitar filtro")),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: PageScrollPhysics(),
                itemCount: dataProd.length,
                itemBuilder: (context, index) {
                  var imagenprod = dataProd[index]['Producto_foto'];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => DetallesProducto(
                          index: index,
                          lista: dataProd,
                        ),
                      ));
                    },
                    child: Container(
                      child: Card(
                        color: Colors.purple,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 25.0,
                            ),
                            Container(
                              width: 250,
                              height: 250,
                              child: dataProd[index]['Producto_foto'] != null ||
                                      dataProd[index]['Producto_foto'] == ""
                                  ? FadeInImage(
                                      image: NetworkImage(
                                          "http://192.168.1.81/lefufuapp/public/uploads/kits/$imagenprod"),
                                      placeholder:
                                          AssetImage('assets/jar-loading.gif'),
                                      height: 500,
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
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 25.0,
                            ),
                            Text(
                              "precio '\$'" +
                                  dataProd[index]['Producto_precio'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 25.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
