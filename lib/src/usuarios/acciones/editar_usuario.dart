import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_tesisv2/src/usuarios/sidebar.dart';
import 'package:flutter_tesisv2/src/usuarios/usuarios.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class EditarUsuario extends StatefulWidget {
  static const String ROUTE = "/editarusuario";

  final int indexCult;

  final List listaCult;

  const EditarUsuario({Key key, this.indexCult, this.listaCult})
      : super(key: key);
  @override
  _EditarUsuarioState createState() => _EditarUsuarioState();
}

class _EditarUsuarioState extends State<EditarUsuario> {
  List dataUsuario = [];
  File fotoi;
  String fotoN;
  String urlIma;
  TextEditingController nombreuController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController contrasenaController = TextEditingController();
  TextEditingController direccionController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController confirmarController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    verUsuariodatos().then((value) {
      dataUsuario = value;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              _tomarFoto();
            },
          ),
          IconButton(
            icon: Icon(Icons.image),
            onPressed: () {
              _seleccionarFoto();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: dataUsuario.length,
        itemBuilder: (context, index) {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 50),
              child: Column(
                key: _formKey,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    child: fotoi == null && urlIma == null
                        ? FadeInImage(
                            image: NetworkImage(
                                dataUsuario[index]['Usuario_foto']),
                            placeholder: AssetImage('assets/jar-loading.gif'),
                            height: 500,
                          )
                        : Image.file(fotoi),
                  ),
                  Container(
                    child: TextFormField(
                      controller: nombreuController,
                      decoration: InputDecoration(
                          labelText: "Nombre :  " +
                              dataUsuario[index]['Usuario_nombre']),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  TextFormField(
                      controller: correoController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "Correo :  " +
                              dataUsuario[index]['Usuario_correo']),
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus()),
                  TextFormField(
                      controller: contrasenaController,
                      decoration: InputDecoration(
                          labelText: "ingrese una nueva contraseña"),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => node.nextFocus()),
                  TextFormField(
                      controller: confirmarController,
                      decoration:
                          InputDecoration(labelText: "repita su contraseña"),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => node.nextFocus()),
                  TextFormField(
                      controller: direccionController,
                      decoration: InputDecoration(
                          labelText: "Direccion :  " +
                              dataUsuario[index]['Usuario_direccion']),
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus()),
                  TextFormField(
                      controller: telefonoController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: "Telefono :  " +
                              dataUsuario[index]['Usuario_telefono']),
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus()),
                  SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (contrasenaController.text ==
                            confirmarController.text) {
                          await editarUsuario();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Cuenta()));
                        } else {
                          Fluttertoast.showToast(
                              msg:
                                  "por favor verifique si su contraseña es igual o cumple con los requisitos");
                        }
                      },
                      child: Text("Editar"))
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<List> verUsuariodatos() async {
    var id = await FlutterSession().get('id');

    var url =
        "http://192.168.1.81/pruebastesis/obtenerUsuarioeditar.php?Usuario_id=$id";
    final response = await http.get(Uri.parse(url));
    final datausu = jsonDecode(response.body);
    return datausu;
  }

  Future _seleccionarFoto() async {
    final pickedFoto =
        await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFoto != null) {
        fotoi = File(pickedFoto.path);
        subirImagenFB(context);
      } else {}
    });
  }

  Future _tomarFoto() async {
    final pickedFoto = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFoto != null) {
        fotoi = File(pickedFoto.path);
        subirImagenFB(context);
      } else {}
    });
  }

  Future subirImagenFB(BuildContext context) async {
    fotoN = path.basename(fotoi.path);
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child("subir")
        .child("/$fotoN");
    final metadata = firebase_storage.SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': fotoN},
    );

    firebase_storage.UploadTask subirTask;

    subirTask = ref.putFile(File(fotoi.path), metadata);

    firebase_storage.UploadTask task = await Future.value(subirTask);
    Future.value(subirTask).then((value) async {
      firebase_storage.Reference imaRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('subir')
          .child('/$fotoN');
      urlIma = await imaRef.getDownloadURL();

      return {print("Upload file path ${value.ref.fullPath}")};
    }).onError((error, stackTrace) =>
        {print("Upload file path error ${error.toString()} ")});
  }

  Future editarUsuario() async {
    var id = await FlutterSession().get('id');

    var url =
        "http://192.168.1.81/pruebastesis/editarUsuario.php?Usuario_id=$id";
    await http.post(Uri.parse(url), body: {
      'Usuario_nombre': nombreuController.text,
      'Usuario_correo': correoController.text,
      'Usuario_contrasena': contrasenaController.text,
      'Usuario_direccion': direccionController.text,
      'Usuario_telefono': telefonoController.text,
      'Usuario_foto':
          urlIma != null ? urlIma.toString() : dataUsuario[0]['Usuario_foto'],
    });
    return true;
  }
}
