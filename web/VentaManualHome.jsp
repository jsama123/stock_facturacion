<%-- 
    Document   : VentaManualHome
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
        <title>VentaManual</title>
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
        <h4>Administrar Venta Manuales</h4>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3">
                    <button class="btn btn-info" onclick="abrirFormulario('insertar')" data-toggle="modal" data-target="#modalForm">Agregar Registro</button>
                </div>
            </div><br>
            <table id="tblVentaManuals" style="font-size: small;" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
                <thead class="table-primary">
                    <tr>
                        <th>FECHA VENTA</th>
                        <th>CAJA</th>
                        <th>CAJERO</th>
                        <th>TIPO DOC EMITIDO</th>
                        <th>NRO FACTURA VENTA</th>
                        <th>ESTADO</th>
                        <th>EDITAR</th>
                        <th>BORRAR</th>
                        <th>DETALLES DE VENTA</th>
                        <th>IMPRIMIR</th>
                    </tr>
                </thead>
                <tbody id="cuerpoVentaManuals" style="">

                </tbody>
            </table>
            <!----------------FORMULARIO -------------->
            <div class="modal fade" id="modalForm" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
                <div class="modal-dialog modal-lg" style="font-size: small;" role="document">
                    <div class="modal-content">
                        <div class="modal-header table-primary">
                            <h5 class="modal-title" id="modalFormTittle">Agregar un nuevo Registro / Venta Manual</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Seleccione una Opcion </label>
                                        <input type="hidden" id="txtId">
                                        <select id="cmbTipoDoc" class="form-control form-control-sm">
                                            <option value="fac">Venta con Factura</option>
                                            <option value="tck">Venta sin Factura</option>
                                        </select>
                                    </div>
                                </div>
                                <div id="divCliente" style="display: none" class="col">
                                    <div class="form-group">
                                        <label>Cliente :</label>
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
                                <div class="col">
                                    <div class="form-group">
                                        <label>Fecha Venta Manual : </label>
                                        <input type="text" id="txtFechaVentaManual" name="camposForm" class="form-control" readonly="true">
                                    </div>
                                </div>
                                <div class="col">
                                    <label>Nro Factura : </label>
                                    <input type="text" id="txtNroFactura" name="camposForm" class="form-control">
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" id="btnCancelar" onclick="limpiarCampos()" data-dismiss="modal">Cancelar</button>
                            <button type="button" id="btnInsertar" class="btn btn-primary" 
                                    onclick="accionProceso(1);">Guardar</button>
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
                            <button type="button" class="btn btn-secondary" id="btnCancelModalClient" onclick="javascript:$('#ciRucClient').val(''); $('#razonCliente').val('');" data-dismiss="modal">Cancelar</button>
                        </div>
                    </div>
                </div>
            </div>
            <!------------------------ MODAL DETALLE ------------->
            <div class="modal fade" id="modalDetalleVentaManual" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
                <div class="modal-dialog modal-lg" style="font-size: small;" role="document">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: powderblue">
                            <h5 class="modal-title" id="modalFormTittle">Detalles de Venta Manuales</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body" style="height: 500px; overflow: scroll;">
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Articulo : </label>
                                        <input type="hidden" id="txtIdVentaManual">
                                        <datalist id="articulos"></datalist>
                                        <input type="text" id="txtArticulo" name="camposFormDetalle" style="font-size: small" placeholder="Ingrese el articulo a buscar.." autocomplete="off" list="articulos" class="form-control form-control-sm">
                                    </div>
                                </div>
                            </div>
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
                                        <select id="cmbDescuentoVentaManual" class="form-control form-control-sm"></select>
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
                                                accionProcesoDetalleVentaManual(1)
                                            } else {
                                                alert('NO SE PUEDE PROCESAR YA QUE LA CANTIDAD INGRESADA SUPERA LA EXISTENCIA DEL ARTICULO !');
                                            }">Insertar</button>
                            <button class="btn btn-sm btn-info" onclick="limpiarCampoDetalle()">Limpiar</button>
                            <label style="display: none" id="sucess" class="alert alert-success">Operacion Realizada !</label>
                            <label style="display: none" id="error"  class="alert alert-warning">No se pudo realizar la operacion !</label><hr/>
                            <table id="tblArticuloVentaManuals" style="font-size: small;" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
                                <thead class="table-primary">
                                <th>ARTICULO</th>
                                <th>CANTIDAD</th>
                                <th>DESC. APLICADO</th>
                                <th>PRECIO C/ DESC</th>
                                <th>SUB-TOTAL C / DESC</th>
                                <th>BORRAR</th>
                                </thead>
                                <tbody id="cuerpoArticuloVentaManualss"></tbody>
                                <tfoot>
                                    <tr>
                                        <th colspan="4" style="font-weight: bold; text-align: right">TOTAL</th>
                                        <th id="thTotalVentaManual" style="font-weight: bold"></th>
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
                                        <input type="text" id="txtPagoVentaManual" class="form-control form-control-sm">
                                    </div>
                                </div>
                            </div><br>
                            <button class="btn btn-sm btn-info" onclick="accionProceso(4, $('#txtIdVentaManual').val())">Procesar Pago</button>
                            <button class="btn btn-sm btn-info" onclick="$('#txtPagoVentaManual').val('')">Limpiar</button>
                            <label style="display: none" id="sucess" class="alert alert-success">Operacion Realizada !</label>
                            <label style="display: none" id="error"  class="alert alert-warning">No se pudo realizar la operacion !</label><hr/>
                            <div class="row">
                                <div class="col">
                                    <table id="tblPagoVentaManual" style="font-size: x-small;" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
                                        <thead class="table-primary">
                                            <tr>
                                                <th>Tipo Pago</th>
                                                <th>Monto</th>
                                                <th>Editar</th>
                                            </tr>
                                        </thead>
                                        <tbody id="cuerpoPagoVentaManual"></tbody>
                                    </table>
                                </div>
                            </div>
                            <button class="btn btn-primary" onclick="finiquitarVentaManualImprimir()">PROCESAR VENTA</button>
                            <button class="btn btn-primary" id="btnCancelVentaManual" style="display: none" data-dismiss="modal">CANCELAR</button>
                        </div>
                    </div>
                </div>
            </div>
    </body>
    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/jquery-ui-1.9.1.custom.js"></script>
    <script src="js/toastr.min.js"></script>
    <script src="js/datatables.min.js"></script>
    <script src="js-sistema/ventaManual.js"></script>
</html>
