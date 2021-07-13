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
        <link rel="shortcut icon" type="image/png" href="imagenes/imagenIcono.png"/>
        <style type="text/css" rel="stylesheet">
            .nav-link {
                font-size: 12px;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <nav class="navbar fixed-top navbar-expand-lg navbar-dark info-color">
            
            <button class="navbar-toggler" type="button" data-toggle="collapse" 
                    data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" 
                    aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul style="font-size: 14px" class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" id="navHome" href="#" onclick="cargarFuncionalidad('PanelHome.jsp')">Inicio <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" 
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Referenciales
                        </a>
                        <ul class="dropdown-menu">
                            <li class="dropdown-item dropdown-submenu">
                                <a href="#" data-toggle="dropdown" style="font-size: 12px; font-weight: bold; height: 25px" class="dropdown-toggle">Articulos </a>
                                <ul class="dropdown-menu">
                                    <li class="dropdown-item">
                                        <a href="#" onclick="cargarFuncionalidad('MarcaHome.jsp')"  title="Administrar Marcas" style="font-size: 12px; font-weight: bold; height: 25px;">Marcas</a>
                                    </li>
                                    <li class="dropdown-item">
                                        <a href="#" onclick="cargarFuncionalidad('MedidaHome.jsp')" title="Administrar Medidas" style="font-size: 12px; font-weight: bold; height: 25px;">Medidas</a>
                                    </li>
                                    <li class="dropdown-item">
                                        <a href="#" onclick="cargarFuncionalidad('GrupoHome.jsp')"  title="Administrar Grupos" style="font-size: 12px; font-weight: bold; height: 25px;">Grupos</a>
                                    </li>
                                    <li class="dropdown-item">
                                        <a href="#" onclick="cargarFuncionalidad('ListaPrecioHome.jsp')" title="Administrar Descuentos" style="font-size: 12px; font-weight: bold; height: 25px;">Descuentos</a>
                                    </li>
                                </ul>
                            </li>
                            <li class="dropdown-item dropdown-submenu">
                                <a href="#" data-toggle="dropdown" style="font-size: 12px; font-weight: bold; height: 25px" class="dropdown-toggle">Ventas / Compras </a>
                                <ul class="dropdown-menu">
                                    <li class="dropdown-item">
                                        <a href="#" onclick="cargarFuncionalidad('ClienteHome.jsp')" style="font-size: 12px; font-weight: bold; height: 25px"   title="Administrar Clientes">Clientes</a>
                                    </li>
                                    <li class="dropdown-item">
                                        <a href="#" onclick="cargarFuncionalidad('ProveedorHome.jsp')" style="font-size: 12px; font-weight: bold; height: 25px" title="Administrar Proveedores">Proveedores</a>
                                    </li>
                                    <li class="dropdown-item">
                                        <a href="#" onclick="cargarFuncionalidad('CajaHome.jsp')" style="font-size: 12px; font-weight: bold; height: 25px" title="Administrar Cajas">Cajas</a>
                                    </li>
                                    <li class="dropdown-item">
                                        <a href="#" onclick="cargarFuncionalidad('SucursalHome.jsp')" title="Administrar Sucursales" style="font-size: 12px; font-weight: bold; height: 25px">Sucursales</a>
                                    </li>
                                    <li class="dropdown-item">
                                        <a href="#" onclick="cargarFuncionalidad('ImpuestoHome.jsp')" title="Administrar Tipo Impuestos" style="font-size: 12px; font-weight: bold; height: 25px">Impuestos</a>
                                    </li>
                                    <li class="dropdown-item">
                                        <a href="#" onclick="cargarFuncionalidad('CajeroHome.jsp')" title="Administrar Cajeros" style="font-size: 12px; font-weight: bold; height: 25px">Cajeros</a>
                                    </li>

                                </ul>
                            </li>
                            <li class="dropdown-item">
                                <a href="#" onclick="cargarFuncionalidad('DepositoHome.jsp')" style="font-size: 12px; font-weight: bold; height: 25px" title="Administrar Depositos">Depositos / Sucursales</a>
                            </li>
                            <li class="dropdown-item">
                                <a href="#" onclick="cargarFuncionalidad('VendedorHome.jsp')"  title="Administrar Vendedores" style="font-size: 12px; font-weight: bold; height: 25px">Vendedores</a>
                            </li>
                            <li class="dropdown-item">
                                <a href="#" onclick="cargarFuncionalidad('TimbradoHome.jsp')"  title="Administrar Timbrados" style="font-size: 12px; font-weight: bold; height: 25px">Timbrados</a>
                            </li>
                            <li class="dropdown-item">
                                <a href="#" onclick="cargarFuncionalidad('ParametroSistemaHome.jsp')"  title="Administrar Parametros" style="font-size: 12px; font-weight: bold; height: 25px">Parametros</a>
                            </li>
                            <li class="dropdown-item">
                                <a href="#" onclick="cargarFuncionalidad('ParametroCuotaVentaHome.jsp')"  title="Administrar Parametros Cuotas Ventas" style="font-size: 12px; font-weight: bold; height: 25px">Parametros Ventas</a>
                            </li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" 
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Articulos
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('ArticuloHome.jsp')"  title="Administrar Articulos" style="font-size: 12px; font-weight: bold; height: 25px">Administrar Articulos</a>
                            <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('StockHome.jsp')" title="Inventariar Articulos" style="font-size: 12px; font-weight: bold; height: 25px">Inventariar Articulos</a>
                            <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('EtiquetaArticuloHome.jsp')" title="Etiquetar Articulos" style="font-size: 12px; font-weight: bold; height: 25px">Etiquetar Articulos</a>
                        </div>
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
                            <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('VentaPendienteHome.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Ventas Pendientes de Procesar</a>
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
                            <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('AjusteMontoTotalCompraHome.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Ajustes de Monto Totales de Compras</a>
                        </div>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" 
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Stocks / Depositos
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('TraspasoHome.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Traspaso entre Depositos</a>
                            <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('AjustesStockHome.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Ajustes de Existencias</a>
                            <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('MalogradoHome.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Articulos Malogrados</a>
                        </div>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" 
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Anulaciones
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('AnularCompraHome.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Anular Compras</a>
                            <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('AnularAjusteStockHome.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Anular Ajustes de Existencias</a>
                            <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('AnularVentaManualHome.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Anular Ventas Manuales</a>
                            <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('AnularTraspasoHome.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Anular Traspasos</a>
                        </div>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" 
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Informes
                        </a>
                        <ul class="dropdown-menu">
                            <li class="dropdown-item dropdown-submenu">
                                <a href="#" data-toggle="dropdown" class="dropdown-toggle" style="font-size: 12px; font-weight: bold; height: 25px">Ventas por Fecha </a>
                                <ul class="dropdown-menu">
                                    <li class="dropdown-item">
                                        <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('ImprimirVentasxFecha.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Ventas por Sistema</a>
                                    </li>
                                    <li class="dropdown-item">
                                        <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('ImprimirVentaManualxFecha.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Ventas Manuales</a>
                                    </li>
                                    <li class="dropdown-item">
                                        <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('ImprimirFacturasPDF.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Consolidado por Facturas</a>
                                    </li>
                                    <li class="dropdown-item">
                                        <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('ImprimirVentaArticuloxFecha.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Consolidado de Articulos / Ventas por Sistema</a>
                                    </li>
                                    <li class="dropdown-item">
                                        <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('ImprimirVentaManualArticuloxFecha.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Consolidado de Articulos / Ventas manuales</a>
                                    </li>
                                    <li class="dropdown-item">
                                        <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('ImprimirRankingClientes.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Ranking de Ventas Clientes</a>
                                    </li>
                                </ul>
                            </li>
                            <li class="dropdown-item">
                                <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('ImprimirVentasxCliente.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Ventas por Cliente</a>
                            </li>
                            <li class="dropdown-item">
                                <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('ImprimirVentaxArticulo.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Ventas por Articulo</a>
                            </li>
                            <li class="dropdown-item">
                                <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('ImprimirDescArticuloxFecha.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Descuento Consolidado de Articulos</a>
                            </li>
                            <li class="dropdown-item dropdown-submenu">
                                <a href="#" data-toggle="dropdown" class="dropdown-toggle" style="font-size: 12px; font-weight: bold; height: 25px">Informes SET </a>
                                <ul class="dropdown-menu">
                                    <li class="dropdown-item">
                                        <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('ImprimirFacturasConsolidadoxFecha.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">INGRESOS / VENTAS POR SISTEMA</a>
                                    </li>
                                    <li class="dropdown-item">
                                        <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('ImprimirIngresosVM.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">INGRESOS / VENTAS MANUALES</a>
                                    </li>
                                    <li class="dropdown-item">
                                        <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('ImprimirEgresosSET.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">EGRESOS</a>
                                    </li>
                                </ul>
                            </li>
                            <li class="dropdown-item dropdown-submenu">
                                <a href="#" data-toggle="dropdown" class="dropdown-toggle" style="font-size: 12px; font-weight: bold; height: 25px">Compras </a>
                                <ul class="dropdown-menu">
                                    <li class="dropdown-item">
                                        <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('ImprimirCompraxFecha.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Compras por Fecha</a>
                                    </li>
                                    <li class="dropdown-item">
                                        <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('ImprimirFacturasCompraConsolidadoxFecha.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Compras Consolidado</a>
                                    </li>
                                    <li class="dropdown-item">
                                        <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('ImprimirCompraArticuloxFecha.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Consolidado de Articulos / Compras</a>
                                    </li>
                                </ul>
                            </li>
                            <li class="dropdown-item">
                                <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('ImprimirCompraxArticulo.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Compras por Articulo</a>
                            </li>
                            <li class="dropdown-item">
                                <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('ImprimirVentasxId.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Impresion de Ventas</a>
                            </li>
                            <li class="dropdown-item">
                                <a class="dropdown-item" href="ReporteListadoProductos.jsp" target="_blank" style="font-size: 12px; font-weight: bold; height: 25px">Catalogo de Articulos</a>
                            </li>
                            <li class="dropdown-item">
                                <a class="dropdown-item" href="ReporteArticulosXLS.jsp" target="_blank" style="font-size: 12px; font-weight: bold; height: 25px">Catalogo de Articulos / Excel</a>
                            </li>
                            <li class="dropdown-item">
                                <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('ImprimirArticuloxDeposito.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Existencia de Articulos por Deposito</a>
                            </li>
                            <li class="dropdown-item">
                                <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('ImprimirArticuloGsxDeposito.jsp')" style="font-size: 12px; font-weight: bold; height: 25px">Valores en Gs por Deposito</a>
                            </li>
                            <li class="dropdown-item">
                                <a class="dropdown-item" href="ReporteExistenciaConsolidado.jsp" target="_blank" style="font-size: 12px; font-weight: bold; height: 25px">Existencia Consolidado</a>
                            </li>
                            <li class="dropdown-item">
                                <a class="dropdown-item" href="ReporteExistenciaConsolidadoXLS.jsp" target="_blank" style="font-size: 12px; font-weight: bold; height: 25px">Existencia Consolidado / Excel</a>
                            </li>
                            <li class="dropdown-item">
                                <a class="dropdown-item" href="ReporteAjusteStock.jsp" target="_blank" style="font-size: 12px; font-weight: bold; height: 25px">Ajustes de Existencias</a>
                            </li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" 
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Sesión
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#" onclick="cargarFuncionalidad('EmpresaHome.jsp')"style="font-size: 12px; font-weight: bold; height: 25px">Datos Perfil</a>
                            
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
                                $(document).ready(function() {
                                    notificacionTimbrado();
                                    $("#navHome").trigger("click");
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
                                        success: function(data, textStatus, jqXHR) {
                                            console.log($.trim(data));
                                        },
                                        error: function(jqXHR, textStatus, errorThrown) {

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
                                        success: function(datos) {
                                            retorno = $.trim(datos);
                                        },
                                        error: function() {
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
