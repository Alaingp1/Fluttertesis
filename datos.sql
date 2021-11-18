-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-11-2021 a las 21:24:39
-- Versión del servidor: 10.4.13-MariaDB
-- Versión de PHP: 7.4.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_indostatuspruebas`
--

--
-- Volcado de datos para la tabla `categoria_producto`
--

INSERT INTO `categoria_producto` (`Categoria_id`, `Categoria_nombre`, `Categoria_estado`) VALUES
(1, 'kits 1 planta', 1),
(2, 'kits 3 planta', 1),
(3, 'kits 5 planta', 1);

--
-- Volcado de datos para la tabla `contacto`
--

INSERT INTO `contacto` (`Contacto_id`, `Usuario_id`, `Contacto_nombre`, `Contacto_email`, `Contacto_telefono`) VALUES
(1, 5, 'soporte', 'soporte@lefufu.cl', 98765432),
(2, 5, 'atencion al cliente', 'atencioncliente@lefufu.cl', 98798776);

--
-- Volcado de datos para la tabla `cultivo`
--

INSERT INTO `cultivo` (`Cultivo_id`, `Sensores_id`, `Tipo_id`, `Usuario_id`, `Cultivo_apodo`, `Cultivo_imagen`, `Cultivo_alarma`, `Cultivo_estado`) VALUES
(1, 0, 4, 7, 'gato qlo', 'https://firebasestorage.googleapis.com/v0/b/lefufudb.appspot.com/o/subir%2Fa31e2a29-06f9-4f92-9568-09868074227f8658231703803003223.jpg?alt=media&token=8bae1856-fb05-4fd3-a8e2-5abedcd3cc68', NULL, 1),
(2, 0, 3, 20, 'gato2', 'https://firebasestorage.googleapis.com/v0/b/lefufudb.appspot.com/o/subir%2F7e3d7b9e-0944-4b7c-8aea-6ee354307cb08488498139316631413.jpg?alt=media&token=af70b53e-a99d-45d0-a2c8-58b7223dcc36', 'se necesita agua', 1),
(3, 0, 3, 20, 'hola comotasod', 'https://firebasestorage.googleapis.com/v0/b/lefufudb.appspot.com/o/subir%2Fimage_picker3934757209791823468.jpg?alt=media&token=175e0345-b456-4dc2-a38b-bedd2043e8ec', 'se ta muriendoooo', 1),
(4, 0, 1, 20, 'mamahuevo', 'https://firebasestorage.googleapis.com/v0/b/lefufudb.appspot.com/o/subir%2F6fa875f9-32a6-426f-84f4-dbf3a4ad10412486492943354530359.jpg?alt=media&token=2d4a274b-3bfa-481e-a874-34bd7ca08c74', NULL, 1),
(5, 0, 3, 20, 'refrigerador', 'https://firebasestorage.googleapis.com/v0/b/lefufudb.appspot.com/o/subir%2F51e4c4ae-61d1-42aa-a775-b4e5c4eb998b1743394202393686712.jpg?alt=media&token=73fbd4ca-284f-4d60-9735-51074fe2986d', NULL, 1),
(6, 0, 4, 20, 'gato', 'https://firebasestorage.googleapis.com/v0/b/lefufudb.appspot.com/o/subir%2F2d8b62a9-49ab-4897-bce4-f323bf4f17c91500968547532536774.jpg?alt=media&token=60042892-5721-42d4-886c-8bf9bbdd9f28', NULL, 1),
(8, 0, 2, 20, 'ahi con los k ', 'https://firebasestorage.googleapis.com/v0/b/lefufudb.appspot.com/o/subir%2Fimage_picker3092024895781420756.jpg?alt=media&token=22dfcc4b-e233-44fa-bfc8-b7183208e811', NULL, 1),
(9, 0, 1, 20, 'hola', 'https://firebasestorage.googleapis.com/v0/b/lefufudb.appspot.com/o/subir%2Fba177c3e-cc32-466f-8d4c-56adee81b1ba3116432025486951383.jpg?alt=media&token=23732ce7-60e4-471e-a50a-784a8371a2e3', NULL, 1),
(15, 0, 2, 20, 'aaa', 'https://firebasestorage.googleapis.com/v0/b/lefufudb.appspot.com/o/subir%2F3fc6a203-2f58-4541-9956-12d89f09e7ef2975744150880543776.jpg?alt=media&token=2367889d-c417-423f-906c-da75cb8436cf', NULL, 1),
(17, 0, 1, 20, 'as', 'https://firebasestorage.googleapis.com/v0/b/lefufudb.appspot.com/o/subir%2Fd164b798-bf12-459f-ae42-8563f669ec4d739877033968143960.jpg?alt=media&token=f72c2918-18e4-4b35-a1f1-c8f81e74da06', NULL, 1),
(19, 0, 2, 20, 'asas', 'https://firebasestorage.googleapis.com/v0/b/lefufudb.appspot.com/o/subir%2F6b2f857c-0616-41d8-8aa3-8e7b63b067ea5272599103284136803.jpg?alt=media&token=223e08c2-ebb7-45ec-a57f-f197db6ae467', NULL, 1);

--
-- Volcado de datos para la tabla `datos_de_la_empresa`
--

INSERT INTO `datos_de_la_empresa` (`Datos_id`, `Usuario_id`, `Datos_mision`, `Datos_vision`, `Datos_comentario`) VALUES
(1, 5, 'Ser especialistas en la innovación y desarrollo de los sistemas para la automatización de cultivos y satisfacer las necesidades de nuestros clientes ofreciéndoles productos de calidad.', 'Ser una empresa productora y comercializadora de sistemas de cuidado para cultivos, caracterizados por la calidad y innovación constante de nuestros procesos, manteniendo la vocación, honestidad y responsabilidad de satisfacer a nuestros clientes.\r\n', ' aqui lo que se nos ocurra');

--
-- Volcado de datos para la tabla `detalle_orden`
--

INSERT INTO `detalle_orden` (`Detalle_id`, `Orden_id`, `Producto_id`, `Detalle_fecha`) VALUES
(1, 1, 3, '2021-11-02'),
(2, 2, 2, '2021-11-02'),
(10, 3, 2, '2021-11-03'),
(11, 96, 2, '2021-11-03'),
(12, 97, 2, '2021-11-03'),
(14, 99, 3, '2021-11-08'),
(15, 100, 2, '2021-11-08'),
(16, 101, 2, '2021-11-08'),
(17, 102, 4, '2021-11-08'),
(18, 103, 2, '2021-11-08'),
(19, 104, 3, '2021-11-08'),
(20, 105, 3, '2021-11-08'),
(21, 106, 2, '2021-11-08'),
(22, 107, 2, '2021-11-08'),
(23, 108, 2, '2021-11-08'),
(24, 109, 2, '2021-11-08'),
(25, 110, 2, '2021-11-08'),
(26, 111, 2, '2021-11-08'),
(27, 112, 2, '2021-11-08'),
(28, 113, 2, '2021-11-10'),
(29, 114, 2, '2021-11-10'),
(30, 115, 2, '2021-11-10'),
(31, 116, 2, '2021-11-10'),
(32, 117, 2, '2021-11-10'),
(33, 118, 2, '2021-11-10'),
(34, 119, 2, '2021-11-10'),
(35, 120, 2, '2021-11-10'),
(36, 121, 2, '2021-11-10'),
(37, 122, 2, '2021-11-10'),
(38, 123, 2, '2021-11-10'),
(39, 124, 2, '2021-11-10');

--
-- Volcado de datos para la tabla `horario_usuario`
--

INSERT INTO `horario_usuario` (`Horario_id`, `Horario_inicio`, `Horario_fin`, `Horario_estado`) VALUES
(1, '08:00:00', '17:30:00', 1);

--
-- Volcado de datos para la tabla `instalacion`
--

INSERT INTO `instalacion` (`Instalacion_id`, `Usuario_id`, `Orden_id`, `Instalacion_estado`) VALUES
(1, 16, 1, 1),
(6, 16, 3, 1),
(7, 16, 98, 1),
(8, 10, 106, 1),
(9, 16, 2, 1);

--
-- Volcado de datos para la tabla `orden`
--

INSERT INTO `orden` (`Orden_id`, `Usuario_id`, `Orden_Fecha`, `Orden_cantidad_productos`, `Orden_estado`) VALUES
(1, 1, '2021-11-12', 44, 1),
(2, 1, '2021-11-12', 44, 1),
(3, 1, '2021-11-12', 44, 1),
(89, 1, '2021-11-05', 44, 1),
(90, 1, '2021-11-05', 44, 1),
(91, 1, '2021-11-05', 44, 1),
(92, 1, '2021-11-05', 44, 1),
(93, 1, '2021-11-05', 44, 1),
(94, 1, '2021-11-05', 44, 1),
(95, 1, '2021-11-05', 44, 1),
(96, 1, '2021-11-05', 44, 1),
(97, 1, '2021-11-05', 44, 1),
(98, 1, '2021-11-12', 10, 1),
(99, 1, '2021-11-09', 9, 1),
(100, 1, '2021-11-22', 55, 1),
(101, 1, '2021-11-22', 22, 1),
(102, 1, '2021-11-12', 33, 1),
(103, 1, '2021-11-23', 3344, 1),
(104, 1, '2021-11-24', 999, 1),
(105, 1, '2021-11-12', 55, 1),
(106, 1, '2021-11-10', 2, 1),
(107, 1, '0000-00-00', 0, 1),
(108, 1, '2021-11-04', 2, 1),
(109, 1, '2021-11-04', 2, 1),
(110, 1, '2021-11-04', 2, 1),
(111, 1, '2021-11-04', 1, 1),
(112, 1, '2021-11-04', 1, 1),
(113, 20, '0000-00-00', 33, 1),
(114, 20, '0000-00-00', 4444, 1),
(115, 20, '0000-00-00', 333, 1),
(116, 20, '0000-00-00', 22, 1),
(117, 20, '2021-11-14', 23, 1),
(118, 20, '0000-00-00', 43, 1),
(119, 20, '0000-00-00', 24, 1),
(120, 20, '0000-00-00', 23, 1),
(121, 20, '0000-00-00', 56, 1),
(122, 20, '0000-00-00', 55, 1),
(123, 20, '0000-00-00', 42, 1),
(124, 20, '2021-11-23', 2432, 1),
(125, 20, '2021-11-17', 63, 1),
(126, 20, '2021-11-17', 17, 1),
(127, 20, '2021-11-17', 50, 1),
(128, 20, '2021-11-17', 51, 1),
(129, 20, '2021-11-17', 100, 1),
(130, 20, '2021-11-17', 0, 1),
(131, 20, '2021-11-17', 1, 1),
(132, 20, '2021-11-17', 56, 1),
(133, 20, '2021-11-17', 0, 1),
(134, 20, '2021-11-17', 44, 1);

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`Producto_id`, `Categoria_id`, `Producto_nombre`, `Producto_descripcion`, `Producto_precio`, `Producto_estado`, `Producto_stock`, `Producto_foto`) VALUES
(2, 1, 'kit interior', 'kit para espacios cerrados', 60000, 1, 0, '1634671153_dbf2f8671c4e60273368.png'),
(3, 2, 'kit interiora', 'kit para espacios cerrados', 150000, 1, 30, '1634666453_4651fa74eebb4a15d76d.png'),
(4, 3, 'kit ineriore', 'kit para espacios pequeños', 250000, 1, 20, '1635383192_616a2bea4e9a9524dd64.png'),
(5, 2, 'refigerador', 'cocina', 25000, 1, 23, '1636596223_2b9a11d63a7a6a03519a.jpg');

--
-- Volcado de datos para la tabla `publicacion`
--

INSERT INTO `publicacion` (`Publicacion_id`, `Usuario_id`, `Publicacion_nombre`, `Publicacion_descripcion`, `Publicacion_imagen`) VALUES
(2, 7, 'gato qlo', 'claramente como se puede  observar el cultivo de poronga que tengo se combirtio en un gato que no es planta y tampoco es un nft y tiene blockchain', 'https://firebasestorage.googleapis.com/v0/b/lefufudb.appspot.com/o/subir%2Fa31e2a29-06f9-4f92-9568-09868074227f8658231703803003223.jpg?alt=media&token=8bae1856-fb05-4fd3-a8e2-5abedcd3cc68'),
(3, 20, 'hola ', 'television', 'https://firebasestorage.googleapis.com/v0/b/lefufudb.appspot.com/o/subir%2Fimage_picker5739263722919804898.jpg?alt=media&token=10b6f2af-4b4a-4a1d-abdc-e931808d7d62'),
(9, 20, 'hola', 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', 'https://firebasestorage.googleapis.com/v0/b/lefufudb.appspot.com/o/subir%2Fba177c3e-cc32-466f-8d4c-56adee81b1ba3116432025486951383.jpg?alt=media&token=23732ce7-60e4-471e-a50a-784a8371a2e3'),
(10, 20, 'refrigerador', 'asasas', 'https://firebasestorage.googleapis.com/v0/b/lefufudb.appspot.com/o/subir%2F51e4c4ae-61d1-42aa-a775-b4e5c4eb998b1743394202393686712.jpg?alt=media&token=73fbd4ca-284f-4d60-9735-51074fe2986d');

--
-- Volcado de datos para la tabla `rol_usuario`
--

INSERT INTO `rol_usuario` (`Rol_id`, `Rol_nombre`, `Rol_estado`) VALUES
(1, 'Trabajador', 1),
(2, 'Usuario', 1),
(3, 'Admin', 1);

--
-- Volcado de datos para la tabla `tipo_cultivo`
--

INSERT INTO `tipo_cultivo` (`Tipo_id`, `Tipo_nombre`, `Tipo_estado`) VALUES
(1, 'gato qlo', 1),
(2, 'marijuaaana', 1),
(3, 'tomate', 1),
(4, 'cocina', 1);

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`Usuario_id`, `Horario_id`, `Rol_id`, `Usuario_nombre`, `Usuario_correo`, `Usuario_contrasena`, `Usuario_direccion`, `Usuario_telefono`, `Usuario_estado`, `Usuario_foto`) VALUES
(1, 1, 2, 'pepe', 'pepe.pepe@pep.cl', 'abc123', 'hola 123', 6868686, 1, 'https://firebasestorage.googleapis.com/v0/b/lefufudb.appspot.com/o/subir%2F037bdf6e-712b-4a17-973a-8d8a44de9b546563059983193440162.jpg?alt=media&token=fbe618c1-527f-4f13-895a-df4f033d8817'),
(5, 1, 1, 'diego', 'gallina@gallina.cl', 'gallina123', 'gallina123', 98765432, 1, 'https://firebasestorage.googleapis.com/v0/b/lefufudb.appspot.com/o/subir%2F037bdf6e-712b-4a17-973a-8d8a44de9b546563059983193440162.jpg?alt=media&token=fbe618c1-527f-4f13-895a-df4f033d8817'),
(7, 1, 2, 'aaa', 'bb@bb.cl', 'bebe1233', 'ccccc', 4343434, 1, 'https://firebasestorage.googleapis.com/v0/b/lefufudb.appspot.com/o/subir%2Fcc2b0215-81c9-4d71-89cc-36ef8dce46ac3489541387007743569.jpg?alt=media&token=116c7a9a-c7d8-4600-9621-ae306643298c'),
(9, 1, 1, 'raul', 'raul@gmail.com', 'fernando1234', 'tucapel', 6465495, 1, NULL),
(10, 1, 3, 'martin', 'martin@gmail.cl', 'Martin123', 'aqya', 0, 1, NULL),
(11, NULL, 2, 'alan  gonzalez', 'asd@fmail.com', 'alanasd1', 'siempre viva 123', 12121212, 1, NULL),
(12, NULL, 2, 'alan', 'paso@gmail.com', 'hola1234', 'didididi232', 83484848, 1, NULL),
(14, NULL, 2, 'hola', 'hola@gmail.co', '$2y$10$2S5.rYKu6wj59USc/ehwgu0lhFhGKrbPraoDNNjCFR/j7Ti2nbb/y', 'rqwrqw', 123213, 1, NULL),
(16, NULL, 1, 'gg', 'gg@gg.cl', '$2y$10$GCJetx6ZZWMs718zLbKMdeI7yCQCAUk67I3G4TGvixD3h0hUspxMO', 'qweqwe212', 123123123, 1, NULL),
(18, 1, 3, 'kevin', 'qwe@gmail.com', '$2y$10$GCJetx6ZZWMs718zLbKMdeI7yCQCAUk67I3G4TGvixD3h0hUspxMO', 'lauca 2145', 666666666, 1, '1739250.png'),
(20, NULL, 2, 'assssss', 'xc@xc.cl', '$2y$10$7En8CHwqg2AwVklYsNULNeC0AX/jyzPOLGAoXZ0ARjiMmI89jYvhu', 'sdsd223', 44444444, 1, 'https://firebasestorage.googleapis.com/v0/b/lefufudb.appspot.com/o/subir%2F5fbd932c-d80a-4269-a6fc-a1e3defcb5f54140652812972588744.jpg?alt=media&token=0d6748b9-2dcf-4cd0-b75c-37a7672aa86f');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
