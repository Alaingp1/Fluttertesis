import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tesisv2/src/productos/acciones/ordenar_producto.dart';
import 'package:flutter_tesisv2/src/usuarios/sidebar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DetallesProducto extends StatefulWidget {
  static const String ROUTE = "/detallesproducto";
  final int index;

  final List lista;

  DetallesProducto({this.index, this.lista});

  @override
  _DetallesProductoState createState() => _DetallesProductoState();
}

class _DetallesProductoState extends State<DetallesProducto> {
  final foto = ImagePicker();
  File fotoi;
  @override
  Widget build(BuildContext context) {
    var imagenprod = widget.lista[widget.index]['Producto_foto'];
    int precio = int.parse(widget.lista[widget.index]['Producto_precio']);
    String preciof =
        NumberFormat("#,###").format(precio).toString().replaceAll(",", ".");
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 131, 163, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed("productos");
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Text(
              widget.lista[widget.index]['Producto_nombre'],
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 250,
              height: 250,
              child: widget.lista[widget.index]['Producto_foto'] != null
                  ? FadeInImage(
                      image: NetworkImage(
                          "http://152.173.207.169/lefufuapp/public/uploads/kits/$imagenprod"),
                      placeholder: AssetImage('assets/jar-loading.gif'),
                      height: 500,
                    )
                  : Image.asset(
                      "assets/no-image.png",
                      fit: BoxFit.fill,
                    ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              widget.lista[widget.index]['Categoria_nombre'],
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 25.0,
            ),
            Text(
              "Descripcion:   " +
                  widget.lista[widget.index]['Producto_descripcion'],
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "Stock:   " + widget.lista[widget.index]['Producto_stock'],
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Precio:  \$ " + preciof,
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15,
            ),
            FlatButton(
              child: Text(
                'Ordenar Producto',
                style: TextStyle(fontSize: 15.0),
              ),
              color: Color.fromRGBO(0, 131, 163, 1),
              textColor: Colors.white,
              onPressed: () => Navigator.pushNamed(context, "ordenarproducto",
                  arguments: widget.lista[widget.index]),
            ),
          ],
        ),
      ),
    );
  }
}
