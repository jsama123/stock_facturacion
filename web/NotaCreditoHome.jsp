<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/datatables.min.css" rel="stylesheet">
        <link href="css/toastr.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
        <link href="css/jquery-ui-1.9.1.custom.min.css" rel="stylesheet">
        <%@include file="ChequearSesion.jsp" %>
        <style>
            body {
                padding-top: 50px;
                padding-left: 10px
            }
            div.ui-datepicker{ font-size:small}
        </style>
        <title>Articulo</title>
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
        <h4>Administrar Notas de Credito</h4>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3">
                    <button class="btn btn-info" onclick="abrirFormulario('insertar')" data-toggle="modal" data-target="#modalForm">Agregar Registro</button>
                </div>
            </div><br>
            <table id="tblNotaCredito" style="font-size: small;" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
                <thead class="table-primary">
                    <tr>
                        <th>CLIENTE</th>
                        <th>FECHA</th>
                        <th>CONCEPTO</th>
                        <th>NRO NOTA DE CREDITO</th>
                        <th>ESTADO</th>
                        <th>EDITAR</th>
                        <th>BORRAR</th>
                        <th>DETALLES</th>
                        <th>IMPRIMIR</th>
                    </tr>
                </thead>
                <tbody id="cuerpoNotaCredito" style="">

                </tbody>
            </table>
            <!----------------FORMULARIO -------------->
            <div class="modal fade" id="modalForm" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
                <div class="modal-dialog modal-lg" style="font-size: small;" role="document">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: powderblue">
                            <h5 class="modal-title" id="modalFormTittle">Agregar un nuevo Registro / Nota de Credito</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Cliente :</label>
                                        <input type="hidden" id="txtIdNota">
                                        <datalist id="clientesNota"></datalist>
                                        <input type="text" id="txtClienteNota" autocomplete="off" placeholder="Ingrese ruc del cliente.." list="clientesNota" name="camposForm" class="form-control">
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label>Concepto : </label>
                                        <select id="cmbConceptoNC" class="form-control" name="cmb" style="font-size: small">
                                            <option value="DA">DEVOLUCION DE ARTICULO</option>
                                            <option value="AV">ANULACION DE VENTA</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <label style="font-weight: bold">Los articulos marcados con * son obligatorios !</label>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" id="btnCancelarNota" data-dismiss="modal">Cancelar</button>
                            <button type="button" id="btnInsertar" class="btn btn-primary" 
                                    onclick="accionProceso(1)">Guardar</button>
                            <button type="button" id="btnModificar" class="btn btn-primary" onclick="accionProceso(2)">Modificar</button>
                            <button type="button" id="btnBorrar" class="btn btn-primary" onclick="accionProceso(3)">Borrar</button>
                        </div>
                    </div>
                </div>
            </div>
            <!----------------MODAL DETALLE ---------------------->
            <div class="modal fade" id="modalDetalleNotaCreditoDetalle" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
                <div class="modal-dialog modal-lg" style="font-size: small;" role="document">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: powderblue">
                            <h5 class="modal-title" id="modalFormTittle">Detalles / Nota de Credito</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body" style="height: 500px; overflow: scroll">
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Ingrese el Nro de Comprobante a procesar : </label>
                                        <input type="hidden" id="txtIdNotaCabecera">
                                        <input type="hidden" id="txtConceptoNota">
                                        <datalist id="ventasList"></datalist>
                                        <input type="text" id="txtVenta" style="font-size: small" autocomplete="off" placeholder="Ingrese nro de comprobante.." list="ventasList" name="camposForm" class="form-control">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div  class="col">
                                    <div style="height: 250px; overflow: scroll" class="form-group">
                                        <label>Seleccione el item a procesar : </label>
                                        <table id="tblItemsVentas" class="table table-striped table-bordered table-sm">
                                            <thead style="font-size: x-small">
                                            <th></th>
                                            <th>Articulo</th>
                                            <th>Cantidad</th>
                                            <th>Precio</th>
                                            <th>Sub-Total</th>
                                            </thead>
                                            <tbody style="font-size: x-small" id="cuerpoImtesVentas">

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div id="rowMontoTotalNota" class="row">
                                <div class="col">
                                    <div class="form-inline">
                                        <label>Monto Total a Procesar : </label>
                                        <input type="text" style="font-weight: bold" id="txtMontoTotalCredito" class="form-control form-control-sm" readonly="">
                                    </div>
                                </div>
                            </div>
                            <button class="btn btn-sm btn-info" onclick="if (validarFechaGarantiaVentas() == 's') {
                                        alert('NO SE PUEDE PROCESAR LA OPERACION. ESTA VENTA YA NO CUENTA CON GARANTIA!! ');
                                    } else {
                                        accionProcesoDetalleNota(1);
                                    }">Insertar</button>
                            <button class="btn btn-sm btn-info" onclick="limpiarDetalleNota()">Limpiar</button>
                            <label style="display: none" id="sucess" class="alert alert-success">Operacion Realizada !</label>
                            <label style="display: none" id="error"  class="alert alert-warning">No se pudo realizar la operacion !</label><hr/>
                            <table id="tblDetalleNotaCreditoDetalle" class="table table-striped table-bordered table-sm">
                                <thead class="table-primary">
                                    <tr>
                                        <th>Articulo</th>
                                        <th>Cantidad</th>
                                        <th>Precio</th>
                                        <th>Sub-Total</th>
                                        <th>Borrar</th>
                                    </tr>
                                </thead>
                                <tbody id="cuerpoDetalleNotaCreditoDetalle"></tbody>
                                <tfoot>
                                    <tr>
                                        <th style="text-align: right; font-weight: bold" colspan="3">Total General</th>
                                        <th id="thTotal" style="font-weight: bold"></th>
                                    </tr>
                                </tfoot>
                            </table>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Observaciones de Nota de Credito : </label>
                                        <textarea id="txtObservacionNC" style="font-size: small" class="form-control"></textarea>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label>Accion Aplicada : </label>
                                        <select id="cmbAccionNC" class="form-control form-control-sm">
                                            <option value="0">MONTO DEVUELTO AL CLIENTE</option>
                                            <option value="1">MONTO A FAVOR DEL CLIENTE EN PROXIMA VENTA</option>
                                            <option value="2">NINGUNA</option>
                                        </select>
                                    </div>
                                </div>
                            </div><hr>
                            <button class="btn btn-dark-green" onclick="accionProceso(4, $('#txtConceptoNota').val(), idVentaRetorno())">PROCESAR NOTA DE CREDITO</button>
                            <button class="btn btn-primary" id="btnCancelNotaCreditoDetalle" data-dismiss="modal">CANCELAR</button>
                        </div>
                    </div>
                </div>
            </div>
    </body>
    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/toastr.min.js"></script>
    <script src="js/datatables.min.js"></script>
    <script src="js/jquery-ui-1.9.1.custom.js"></script>
    <script src="js-sistema/notaCredito.js"></script>
</html>
