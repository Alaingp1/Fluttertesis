import 'package:flutter/material.dart';

import 'package:flutter_tesisv2/src/usuarios/acciones/listar_publicaciones.dart';

import 'package:http/http.dart' as http;

class DetallePublicacion extends StatefulWidget {
  final int indexPub;

  final List listaPub;

  const DetallePublicacion({Key key, this.indexPub, this.listaPub})
      : super(key: key);

  @override
  _DetallePublicacionState createState() => _DetallePublicacionState();
}

class _DetallePublicacionState extends State<DetallePublicacion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed("listapub");
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              var url =
                  "http://152.173.207.169/pruebastesis/eliminarPublicacion.php";
              await http.post(Uri.parse(url), body: {
                "Publicacion_id": widget.listaPub[widget.indexPub]
                    ['Publicacion_id']
              });
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListaPublicaciones()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Container(
          child: Column(
            children: [
              Center(
                  child: FadeInImage(
                image: NetworkImage(
                    widget.listaPub[widget.indexPub]['Publicacion_imagen']),
                placeholder: AssetImage('assets/jar-loading.gif'),
              )),
              SizedBox(
                height: 30,
              ),
              Text(
                "Nombre Publicacion:  " +
                    widget.listaPub[widget.indexPub]['Publicacion_nombre'],
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Divider(),
              Divider(),
              Text(
                "Descreipcion:  " +
                    widget.listaPub[widget.indexPub]['Publicacion_descripcion'],
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
