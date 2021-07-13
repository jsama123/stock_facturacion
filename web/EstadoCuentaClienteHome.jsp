<%-- 
    Document   : VentaHome
    Created on : 3/06/2020, 07:35:17 PM
    Author     : Jose Samaniego
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/datatables.min.css" rel="stylesheet">
        <link href="css/jquery-ui-1.9.1.custom.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
        <link href="css/toastr.min.css" rel="stylesheet">
        <%@include file="ChequearSesion.jsp" %>
        <style>
            body {
                padding-top: 50px;
                padding-left: 10px
            }

            datalist {
                max-height: 500px;
                overflow-y: auto;
            }
        </style>
        <title>Venta</title>
    </head>
    <body>
        <div id="cargando">
            <center>
                <button class="btn btn-primary" type="button" disabled>
                    <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                    Cargando...
                </button>
            </center>
        </div>
        <h4>Estado Cuenta de Clientes</h4>
        <div class="container-fluid"><br>
            <table id="tblEstadoCuenta" style="font-size: small;" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
                <thead class="table-primary">
                    <tr>
                        <th>FECHA VENTA</th>
                        <th>CLIENTE</th>
                        <th>NRO COMPROBANTE</th>
                        <th>MONTOS DE VENTA</th>
                        <th>DETALLES / CUOTAS</th>
                    </tr>
                </thead>
                <tbody id="cuerpoEstadoCuenta" style="">

                </tbody>
            </table>
            <!----------------FORMULARIO -------------->
            <div class="modal fade" id="modalForm" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
                <div class="modal-dialog modal-lg" style="font-size: small;" role="document">
                    <div class="modal-content">
                        <div class="modal-body">
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Seleccione una Opcion </label>
                                        <input type="hidden" id="txtId">
                                        <select id="cmbTipoDoc" class="form-control form-control-sm">
                                            <option value="fac">Factura</option>
                                            <option value="tck">Ticket</option>
                                        </select>
                                    </div>
                                </div>
                                <div id="divCliente" style="display: none" class="col">
                                    <div class="form-group">
                                        <label>Cliente :</label><span style="color: red">*</span>
                                        <datalist id="clientes"></datalist>
                                        <input type="text" id="txtCliente" autocomplete="off" placeholder="Ingrese ruc del cliente.." list="clientes" name="camposForm" class="form-control">
                                        <label style="font-size: small"><a href="#" data-toggle='modal' data-target='#modalAgregarCliente'>Agregar Cliente</a></label>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Caja : </label>
                                        <select id="cmbCaja" class="form-control form-control-sm"></select>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label>Cajero : </label>
                                        <select id="cmbCajero" class="form-control form-control-sm"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col" style="display: none">
                                    <div class="form-group">
                                        <label>Fecha Venta : </label><span style="color: red">*</span>
                                        <input type="text" id="txtFechaVenta" name="camposForm" class="form-control" readonly="true">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Tipo de Venta : </label>
                                        <select id="cmbTipoVenta" class="form-control form-control-sm">
                                            <option value="CON">CONTADO</option>
                                            <option value="CRE">CREDITO</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col" id="divColCuotas" style="display: none">
                                    <div class="form-group">
                                        <label>Cantidad de Cuotas : </label>
                                        <select id="cmbCantCuotaEstadoCuenta" class="form-control form-control-sm">
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col" id="divColFecha" style="display: none">
                                    <div class="form-group">
                                        <label>Fecha Vencimiento Primera Cuota : </label>
                                        <input type="text" id="txtFechaVencCuota" name="camposForm" class="form-control" readonly="true">
                                    </div>
                                </div>
                                <div class="col">
                                    <label style="font-weight: bold">Los campos marcados con * son obligatorios !!</label>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" id="btnCancelar" onclick="limpiarCampos()" data-dismiss="modal">Cancelar</button>
                            <button type="button" id="btnInsertar" class="btn btn-primary" 
                                    onclick="if (validarArqueoCajaAbierto() == 's') {
                                                if ($('#cmbTipoDoc').val() == 'fac') {
                                                    if (validarTimbradoVigente() == 's') {
                                                        accionProceso(1);
                                                    } else {
                                                        alert('NO SE PUEDEN EMITIR FACTURAS YA QUE NO CUENTA CON TIMBRADO VIGENTE !!');
                                                    }
                                                } else {
                                                    accionProceso(1);
                                                }
                                            } else {
                                                alert('NO PUEDE REALIZAR REGISTRO DE VENTAS YA QUE NO HA REALIZADO LA APERTURA DE SU CAJA !!');
                                            }">Guardar</button>
                            <button type="button" id="btnModificar" class="btn btn-primary" onclick="accionProceso(2)">Modificar</button>
                            <button type="button" id="btnBorrar" class="btn btn-primary" onclick="accionProceso(3)">Borrar</button>
                        </div>
                    </div>
                </div>
            </div>
            <!------------------------ MODAL AGREGAR CLIENTE ------------->
            <div id="modalAgregarCliente" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header table-primary">
                            <h6 style="color:black">Agregar Cliente</h6>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="ciRucClient">CI / RUC</label>
                                <input type="text" id="ciRucClient" class="form-control camposForm">
                            </div>
                            <div class="form-group">
                                <label for="razonCliente">Razon Social</label>
                                <input type="text" id="razonCliente" class="form-control camposForm">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-success" onclick="insertarCliente(1)" id="agregarEspec" data-dismiss="modal">Agregar</button>
                            <button type="button" class="btn btn-secondary" id="btnCancelModalClient" onclick="javascript:$('#ciRucClient').val('');
                                    $('#razonCliente').val('');" data-dismiss="modal">Cancelar</button>
                        </div>
                    </div>
                </div>
            </div>
            <!------------------------ MODAL DETALLE ------------->
            <div class="modal fade" id="modalDetalleVenta" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
                <div class="modal-dialog modal-lg" style="font-size: small;" role="document">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: powderblue">
                            <h5 class="modal-title" id="modalFormTittle">Detalles de EstadoCuenta</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body" style="height: 500px; overflow: scroll;">
                            <div class="row" id="filaBusquedaCodBarra">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Busqueda por Codigo de Barra : </label><br>
                                        <input type="text" id="txtCodBarraBusqueda" name="camposFormDetalle" size="45" style="font-size: small" placeholder="Ingrese el Codigo de Barra a buscar.." autocomplete="off">
                                        <input type="text" id="txtArticulo2" name="camposFormDetalle" style="font-size: small" autocomplete="off" class="form-control form-control-sm" readonly="">
                                    </div>
                                </div>
                            </div>
                            <div class="row" id="filaBusquedaDescri">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Articulo : </label>
                                        <input type="hidden" id="txtIdVenta">
                                        <datalist id="articulos"></datalist>
                                        <input type="text" id="txtArticulo" name="camposFormDetalle" style="font-size: small" placeholder="Ingrese el articulo a buscar.." autocomplete="off" list="articulos" class="form-control form-control-sm">
                                    </div>
                                </div>
                            </div>
                            <label style="font-size: small">Buscar por Codigo de Barra : <input type="checkbox" id="chkBusquedaCodBarra"></label>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Cantidad : </label>
                                        <input type="text" id="cantidadArticulo" name="camposFormDetalle" size="40px" autocomplete="off" class="form-control form-control-sm">
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label>Descuento a Aplicar:</label>
                                        <select id="cmbDescuentoVenta" class="form-control form-control-sm"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-inline">
                                        <label>Aplicar descuento en Gs  </label><input type="checkbox" id="chkDescGs"> 
                                    </div>
                                </div>
                                <div style="display: none" id="divMontoDescGs" class="col">
                                    <div class="form-inline">
                                        <label>Monto a descontar : </label>
                                        <input type="text" class="form-control form-control-sm" name="camposFormDetalle" id="txtMontoGsDesc">
                                    </div>
                                </div>
                            </div>
                            <button class="btn btn-sm btn-info" 
                                    onclick="if ($('#cantidadArticulo').val() == '') {
                                                alert('Ingrese la cantidad !');
                                            } else if (validarCantidadNosupereExistencia() == 'n') {
                                                accionProcesoDetalleVenta(1)
                                            } else {
                                                alert('NO SE PUEDE PROCESAR YA QUE LA CANTIDAD INGRESADA SUPERA LA EXISTENCIA DEL ARTICULO !');
                                            }">Insertar</button>
                            <button class="btn btn-sm btn-info" onclick="limpiarCampoDetalle()">Limpiar</button>
                            <label style="display: none" id="sucess" class="alert alert-success">Operacion Realizada !</label>
                            <label style="display: none" id="error"  class="alert alert-warning">No se pudo realizar la operacion !</label><hr/>
                            <table id="tblArticuloEstadoCuenta" style="font-size: small;" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
                                <thead class="table-primary">
                                <th>ARTICULO</th>
                                <th>CANTIDAD</th>
                                <th>DESC. APLICADO</th>
                                <th>PRECIO C/ DESC.</th>
                                <th>SUB-TOTAL C/ DESC.</th>
                                <th>BORRAR</th>
                                </thead>
                                <tbody id="cuerpoArticuloEstadoCuentas"></tbody>
                                <tfoot>
                                    <tr>
                                        <th colspan="4" style="font-weight: bold; text-align: right">TOTAL A PAGAR </th>
                                        <th id="thTotalVenta" style="font-weight: bold"></th>
                                    </tr>
                                </tfoot>
                            </table><hr>
                            <!------------------------ REGISTRAR PAGO ------------->
                            <h6 style="font-weight: bold">Registrar Pago</h6>
                            <div class="row">
                                <div class="col">
                                    <div class="form-inline">
                                        <label>Tipo de Pago:</label>
                                        <select id="cmbTipoPago" class="form-control form-control-sm"></select>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-inline">
                                        <label>Monto:</label>
                                        <input type="text" id="txtPagoVenta" class="form-control form-control-sm">
                                    </div>
                                </div>
                            </div><br>
                            <div class="row" id="filaBoletaTarjeta" style="display: none">
                                <div class="col">
                                    <div class="form-inline">
                                        <label>Nro de Boleta:</label>
                                        <input type="text" id="txtNroBoleta" class="form-control form-control-sm">
                                    </div>
                                </div>
                                <div class="col">

                                </div>
                            </div><br>
                            <button class="btn btn-sm btn-info" onclick="if (parseInt($('#txtPagoVenta').val()) < parseInt(retornarTotalVenta())) {
                                        alert('EL MONTO INGRESADO ES MENOR AL TOTAL DE LA VENTA');
                                    } else {
                                        accionProceso(4, $('#txtIdVenta').val())
                                    }">Procesar Pago</button>
                            <button class="btn btn-sm btn-info" onclick="$('#txtPagoVenta').val('');
                                    $('#txtNroBoleta').val('');">Limpiar</button>
                            <label style="display: none" id="sucess" class="alert alert-success">Operacion Realizada !</label>
                            <label style="display: none" id="error"  class="alert alert-warning">No se pudo realizar la operacion !</label><hr/>
                            <div class="row">
                                <div class="col">
                                    <table id="tblPagoVenta" style="font-size: x-small;" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
                                        <thead class="table-primary">
                                            <tr>
                                                <th>Tipo Pago</th>
                                                <th>Monto</th>
                                                <th>Editar</th>
                                            </tr>
                                        </thead>
                                        <tbody id="cuerpoPagoVenta"></tbody>
                                    </table>
                                </div>
                            </div>
                            <button class="btn btn-primary" id="btnProcesarVenta" onclick="if (validarInconsistenciasArticulosVenta() == 'n') {
                                        finiquitarVentaImprimir();
                                    } else {
                                        alert('NO SE PUEDE PROCESAR LA VENTA YA QUE LOS SIGUIENTES ARTICULOS CUENTAN CON INCONSISTENCIAS : '+articulosIncosistencia());
                                    }">PROCESAR VENTA E IMPRIMIR</button>
                            <button class="btn btn-primary" id="btnCancelVenta" style="display: none" data-dismiss="modal">CANCELAR</button><br><br>
                            <h6 id="mensajeProcesandoVenta" style="font-weight: bold; display: none">Procesando..</h6>
                        </div>
                    </div>
                </div>
            </div>
    </body>
    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/jquery-ui-1.9.1.custom.js"></script>
    <script src="js/toastr.min.js"></script>
    <script src="js/datatables.min.js"></script>
    <script src="js-sistema/venta.js"></script>
</html>
