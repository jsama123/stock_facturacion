<%-- 
    Document   : principal
    Created on : 26/05/2020, 08:51:06 PM
    Author     : Jose Samaniego
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="ChequearSesion.jsp" %>
<%    HttpSession sesion = request.getSession(true);
    String loginUsuario = (String) sesion.getAttribute("loginUsuario");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/mdb.min.css" rel="stylesheet">
        <link href="css/toastr.min.css" rel="stylesheet">
        <style type="text/css" rel="stylesheet">
            .nav-link {
                font-size: 12px;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <nav class="navbar fixed-top navbar-expand-lg navbar-dark info-color">
            <a class="navbar-brand" href="#">
                <img src="imagenes/Logo_wicomnet_FondoTrasparente2.png" width="100" height="30" class="d-inline-block align-top" alt="">

            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" 
                    data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" 
                    aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul style="font-size: 14px" class="navbar-nav mr-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" 
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Referenciales
                        </a>
                        <ul class="dropdown-menu">
                            <li class="dropdown-item dropdown-submenu">
                                <a href="#" data-toggle="dropdown" style="font-size: 12px; font-weight: bold; height: 25px" class="dropdown-toggle">Ventas / Compras </a>
                                <ul class="dropdown-menu">
                                    <li class="dropdown-item">
                                        <a href="#" onclick="cargarFuncionalidad('ClienteHome.jsp')" style="font-size: 12px; font-weight: bold; height: 25px"   title="Administrar Clientes">Clientes</a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" 
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Ingresos
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('ArqueoCajaHome.jsp')" style="font-size: 12px; font-weight: bold; height: 25px" >Arqueo de Caja</a>
                            <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('VentaHome.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Ventas y Facturacion</a>
                            <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('VentaManualHome.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Ventas Manuales</a>
                            <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('NotaPresupuestoHome.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Nota de Presupuesto</a>
                        </div>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" 
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Egresos
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('CompraHome.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Compra de Productos</a>
                            <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('GastoHome.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Gastos</a>
                        </div>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" 
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Sesión
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('EmpresaHome.jsp')"style="font-size: 12px; font-weight: bold; height: 25px">Datos Perfil</a>
                            <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('CambiarPass.jsp')"style="font-size: 12px; font-weight: bold; height: 25px">Cambiar Contraseña</a>
                            <a class="dropdown-item" href="Logout.jsp" style="font-size: 12px; font-weight: bold; height: 25px">Cerrar Sesión</a>
                        </div>
                    </li>
                </ul>
                <div class="div-inline my-2 my-lg-0" style="color: white;">
                    <label>Usted se ha logeado como : </label> <label style="font-weight: bold"><%=loginUsuario%></label>
                </div>
            </div>
        </nav><br><br>
        <div id="contenedor"></div>
        <script src="js/jquery-3.4.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/mdb.min.js"></script>
        <script src="js/toastr.min.js"></script>
        <script type="text/javascript">
                                $(document).ready(function () {
                                    notificacionTimbrado();
                                });

                                function notificacionTimbrado() {
                                    if (isPastDate(obtenerFechaFinTimbrado()) == "s") {
                                        actualizarEstadoTimbrado(4);
                                        toastr.warning("¡Atención!, su timbrado a llegado a su fin de vigencia. Para seguir generando facturas \n\
                            debe registrar los datos de su nuevo timbrado ", "Notificación", {
                                            "progressBar": true,
                                            "positionClass": "toast-top-center",
                                            "timeOut": 9000,
                                        });
                                    }
                                }

                                function actualizarEstadoTimbrado(opcion) {

                                    $.ajax({
                                        async: false,
                                        cache: false,
                                        url: "TimbradoControl",
                                        type: 'POST',
                                        data: {
                                            opcion: opcion
                                        },
                                        dataType: 'html',
                                        success: function (data, textStatus, jqXHR) {
                                            console.log($.trim(data));
                                        },
                                        error: function (jqXHR, textStatus, errorThrown) {

                                        }
                                    });

                                }

                                function cargarFuncionalidad(url) {
                                    $("#contenedor").load(url);
                                }

                                function obtenerFechaFinTimbrado() {
                                    var retorno = "";
                                    var resultado = $.ajax({
                                        async: false,
                                        cache: false,
                                        url: 'TimbradoDatos.jsp',
                                        type: 'POST',
                                        data: {
                                            opcion: 3
                                        },
                                        dataType: 'html',
                                        success: function (datos) {
                                            retorno = $.trim(datos);
                                        },
                                        error: function () {
                                            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
                                        }
                                    });
                                    return retorno;
                                }

                                function isPastDate(dateText) {
                                    var n = "nada";
                                    var inputDate = dateText.split("/");
                                    var today = new Date();
                                    inputDate = new Date(inputDate[2], inputDate[1] - 1, inputDate[0], 0, 0, 0, 0);
                                    today = new Date(today.getFullYear(), today.getMonth(), today.getDate(), 0, 0, 0, 0);
                                    if (inputDate <= today) {
                                        n = "s";
                                    } else {
                                        n = "n";
                                    }
                                    return n;
                                }

        </script>
    </body>
</html>
