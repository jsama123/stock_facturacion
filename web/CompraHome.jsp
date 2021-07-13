<%-- 
    Document   : CompraHome
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
        <title>Compra</title>
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
        <h4>Administrar Compras</h4>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3">
                    <button class="btn btn-info" onclick="abrirFormulario('insertar')" data-toggle="modal" data-target="#modalForm">Agregar Registro</button>
                </div>
            </div><br>
            <table id="tblCompras" style="font-size: small;" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
                <thead class="table-primary">
                    <tr>
                        <th>FECHA COMPRA</th>
                        <th>TIPO DE COMPRA</th>
                        <th>PROVEEDOR</th>
                        <th>NRO FACTURA COMPRA</th>
                        <th>MONTOS DE COMPRA</th>
                        <th>ESTADO</th>
                        <th>EDITAR</th>
                        <th>BORRAR</th>
                        <th>DETALLES DE COMPRA</th>
                        <th>REGISTRAR PAGOS PENDIENTES</th>
                        <th>IMPRIMIR</th>
                    </tr>
                </thead>
                <tbody id="cuerpoCompras" style="">

                </tbody>
            </table>
            <!----------------FORMULARIO -------------->
            <div class="modal fade" id="modalForm" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
                <div class="modal-dialog modal-lg" style="font-size: small;" role="document">
                    <div class="modal-content">
                        <div class="modal-header table-primary">
                            <h5 class="modal-title" id="modalFormTittle">Agregar un nuevo Registro / Compra Manual</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Proveedor : <span style="color: red; font-weight: bold">*</span></label>
                                        <input type="hidden" id="txtId">
                                        <datalist id="proveedores"></datalist>
                                        <input type="text" id="txtProveedor" autocomplete="off" placeholder="Ingrese ruc del proveedor.." list="proveedores" name="camposForm" class="form-control">
                                        <label style="font-size: small"><a href="#" data-toggle='modal' data-target='#modalAgregarProveedor'>Agregar Proveedor</a></label>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label>Deposito Afectado :<span style="color: red; font-weight: bold">*</span></label>
                                        <select class="form-control form-control-sm" id="cmbDepositoDestino"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Caja : <span style="color: red; font-weight: bold">*</span></label>
                                        <select id="cmbCaja" class="form-control form-control-sm"></select>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label>Cajero : <span style="color: red; font-weight: bold">*</span> </label>
                                        <select id="cmbCajero" class="form-control form-control-sm"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Fecha Compra : <span style="color: red; font-weight: bold">*</span></label>
                                        <input type="text" id="txtFechaCompra" name="camposForm" class="form-control" readonly="true">
                                    </div>
                                </div>
                                <div class="col">
                                    <label>Nro Factura Compra : <span style="color: red; font-weight: bold">*</span> </label>
                                    <input type="text" id="txtNroFacturaCompra" name="camposForm" class="form-control">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Tipo Compra : <span style="color: red; font-weight: bold">*</span></label>
                                        <select id="cmbTipoCompra" class="form-control">
                                            <option value="CON">CONTADO</option>
                                            <option value="CRE">CREDITO</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col">
                                    <label>Timbrado Compra : <span style="color: red; font-weight: bold">*</span></label>
                                    <input type="text" id="txtTimbradoCompra" name="camposForm" class="form-control">
                                </div>
                            </div>
                            <div id="divRowCre" class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Cantidad Cuotas : </label>
                                        <input type="text" id="txtCuotaCompra" name="camposForm" class="form-control">
                                    </div>
                                </div>
                                <div class="col">
                                    <label>Fecha Vencimiento Cuotas : </label>
                                    <input type="text" id="txtFechaCuo" name="camposForm" class="form-control form-control-sm">
                                </div>
                            </div>
                            <div class="row" id="divMontoEn">
                                <div class="col">
                                    <label>Monto Entregado : </label>
                                    <input type="text" id="txtMontoEntregadoCompra" name="camposForm" class="form-control">
                                </div>
                                <div class="col">
                                    <label style="font-weight: bold">Los articulos marcados con * son obligatorios !</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <label style="font-weight: bold">Los articulos marcados con * son obligatorios !</label>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" id="btnCancelar" onclick="limpiarCampos()" data-dismiss="modal">Cancelar</button>
                            <button type="button" id="btnInsertar" class="btn btn-primary" 
                                    onclick="if (validarNroFacturaDuplicado() == 's') {
                                                alert('Ya existe un registro con el nro de factura ingresado !!');
                                                $('#txtNroFacturaCompra').val('');
                                                $('#txtNroFacturaCompra').focus();
                                            }else{
                                                accionProceso(1);
                                            }">Guardar</button>
                            <button type="button" id="btnModificar" class="btn btn-primary" onclick="accionProceso(2)">Modificar</button>
                            <button type="button" id="btnBorrar" class="btn btn-primary" onclick="accionProceso(3)">Borrar</button>
                        </div>
                    </div>
                </div>
            </div>
            <!------------------------ MODAL AGREGAR PROVEEDOR ------------->
            <div id="modalAgregarProveedor" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header table-primary">
                            <h6 style="color:black">Agregar Proveedor</h6>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="ciRucProveedor">CI / RUC</label>
                                <input type="text" id="ciRucProveedor" class="form-control camposForm">
                            </div>
                            <div class="form-group">
                                <label for="razonProveedor">Razon Social</label>
                                <input type="text" id="razonProveedor" class="form-control camposForm">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-success" onclick="insertarProveedor(1)" id="agregarEspec" data-dismiss="modal">Agregar</button>
                            <button type="button" class="btn btn-secondary" id="btnCancelModalProveedor" onclick="javascript:$('#ciRucProveedor').val('');
                                    $('#razonProveedor').val('');" data-dismiss="modal">Cancelar</button>
                        </div>
                    </div>
                </div>
            </div>
            <!------------------------ MODAL DETALLE ------------->
            <div class="modal fade" id="modalDetalleCompra" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
                <div class="modal-dialog modal-lg" style="font-size: small;" role="document">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: powderblue">
                            <h5 class="modal-title" id="modalFormTittle">Detalles de Compra</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body" style="height: 500px; overflow: scroll;">
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Articulo : </label>
                                        <input type="hidden" id="txtIdCompra">
                                        <input type="hidden" id="txtIdDeposito">
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
                                </div>
                            </div>
                            <button class="btn btn-sm btn-info" 
                                    onclick="if ($('#cantidadArticulo').val() == '') {
                                                alert('Ingrese la cantidad !');
                                            } else {
                                                accionProcesoDetalleCompra(1)
                                            }">Insertar</button>
                            <button class="btn btn-sm btn-info" onclick="limpiarCampoDetalle()">Limpiar</button>
                            <label style="display: none" id="sucess" class="alert alert-success">Operacion Realizada !</label>
                            <label style="display: none" id="error"  class="alert alert-warning">No se pudo realizar la operacion !</label>
                            <label style="display: none" id="sucessArt" class="alert alert-success">Se actualizo el costo del articulo !</label>
                            <label style="display: none" id="errorArt"  class="alert alert-warning">No se pudo realizar la actualizacion del costo del articulo !</label><hr/>
                            <table id="tblArticuloCompras" style="font-size: small;" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
                                <thead class="table-primary">
                                <th>ARTICULO</th>
                                <th>CANTIDAD</th>
                                <th>PRECIO</th>
                                <th>SUB-TOTAL</th>
                                <th>BORRAR</th>
                                </thead>
                                <tbody id="cuerpoArticuloComprass"></tbody>
                                <tfoot>
                                    <tr>
                                        <th colspan="3" style="font-weight: bold; text-align: right">TOTAL</th>
                                        <th id="thTotalCompra" colspan="2" style="font-weight: bold"></th>
                                    </tr>
                                </tfoot>
                            </table><hr>
                            <button class="btn btn-primary" onclick="finiquitarCompraImprimir()">PROCESAR COMPRA</button>
                            <button class="btn btn-primary" id="btnCancelCompra" style="display: none" data-dismiss="modal">CANCELAR</button>
                        </div>
                    </div>
                </div>
            </div>
            <!------------------------ MODAL REGISTRAR PAGOS CUOTAS ------------->
            <div class="modal fade" id="modalDetallePagos" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
                <div class="modal-dialog modal-lg" style="font-size: small;" role="document">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: powderblue">
                            <h5 class="modal-title" id="modalFormTittle">Registrar Pagos / Cuotas Compra </h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body" style="height: 500px; overflow: scroll;">
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Fecha de Pago Cuota : </label>
                                        <input type="hidden" id="txtIdCompra2">
                                        <input type="text" id="txtFechaPagoCuo" name="camposForm" class="form-control" readonly="true">
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label>Tipo Comprobante : </label>
                                        <select class="form-control form-control-sm" id="cmbTipoComprobante"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Nro Comprobante Pago : </label>
                                        <input type="text" id="txtNroCompPago" name="camposFormDetalle" size="40px" autocomplete="off" class="form-control form-control-sm">
                                    </div>
                                </div>
                                <div class="col">
                                    <label>Monto Pagado : </label>
                                    <input type="text" id="txtMontoCuoPago" name="camposFormDetalle" size="40px" autocomplete="off" class="form-control form-control-sm">
                                </div>
                            </div>
                            <button class="btn btn-sm btn-info" 
                                    onclick="accionProcesoCuotaCompra(1)">Insertar</button>
                            <button class="btn btn-sm btn-info" onclick="limpiarCampoDetalle()">Limpiar</button>
                            <label style="display: none" id="sucess2" class="alert alert-success">Operacion Realizada !</label>
                            <label style="display: none" id="error2"  class="alert alert-warning">No se pudo realizar la operacion !</label><hr/>
                            <table id="tblCuotaCompra" style="font-size: small;" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
                                <thead class="table-primary">
                                <th>FECHA DE PAGO</th>
                                <th>TIPO COMPROBANTE</th>
                                <th>NRO COMPROBANTE</th>
                                <th>MONTO PAGADO</th>
                                <th>BORRAR</th>
                                </thead>
                                <tbody id="cuerpoCuotaCompra"></tbody>
                            </table><hr>
                            <button class="btn btn-primary" id="btnCancelCompra" style="display: none" data-dismiss="modal">CANCELAR</button>
                        </div>
                    </div>
                </div>
            </div>
    </body>
    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/jquery-ui-1.9.1.custom.js"></script>
    <script src="js/toastr.min.js"></script>
    <script src="js/datatables.min.js"></script>
    <script src="js-sistema/compra.js"></script>
</html>
