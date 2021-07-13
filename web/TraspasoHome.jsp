<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/datatables.min.css" rel="stylesheet">
        <link href="css/toastr.min.css" rel="stylesheet">
        <link href="css/jquery-ui-1.9.1.custom.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
        <%@include file="ChequearSesion.jsp" %>
        <style>
            body {
                padding-top: 50px;
                padding-left: 10px
            }
        </style>
        <title>Traspasos</title>
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
        <h4>Administrar Traspasos</h4>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3">
                    <button class="btn btn-info" onclick="abrirFormulario('insertar')" data-toggle="modal" data-target="#modalForm">Agregar Registro</button>
                </div>
            </div><br>
            <table id="tblTraspasos" style="font-size: small;" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
                <thead class="table-primary">
                    <tr>
                        <th>DEPOSITO ORIGEN</th>
                        <th>DEPOSITO DESTINO</th>
                        <th>FECHA TRASPASO</th>
                        <th>ESTADO</th>
                        <th>EDITAR</th>
                        <th>BORRAR</th>
                        <th>DETALLES DE TRASPASO</th>
                        <th>IMPRIMIR</th>
                    </tr>
                </thead>
                <tbody id="cuerpoTraspasos" style="">

                </tbody>
            </table>
            <!----------------FORMULARIO -------------->
            <div class="modal fade" id="modalForm" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
                <div class="modal-dialog modal-lg" style="font-size: small;" role="document">
                    <div class="modal-content">
                        <div class="modal-header table-primary">
                            <h5 class="modal-title" id="modalFormTittle">Agregar un nuevo Registro / Traspaso</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Deposito Origen: <span style="color: red; font-weight: bold">*</span></label>
                                        <input type="hidden" id="txtId">
                                        <select id="cmbDepOrigen" name="camposForm" class="form-control form-control-sm"></select>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label>Deposito Destino: <span style="color: red; font-weight: bold">*</span></label>
                                        <select id="cmbDepDestino"  name="camposForm" class="form-control form-control-sm"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Fecha Traspaso :</label>
                                        <input type="text" id="txtFechaTraspaso" name="camposForm" class="form-control" readonly="true">
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label>Observacion : </label>
                                        <textarea id="txtObserTraspaso" name="camposForm" class="form-control"></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <label style="font-weight: bold; color: cadetblue">Los campos con * son obligatorios</label>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" id="btnCancelar" onclick="limpiarCampos()" data-dismiss="modal">Cancelar</button>
                            <button type="button" id="btnInsertar" class="btn btn-primary" onclick="accionProceso(1)">Guardar</button>
                            <button type="button" id="btnModificar" class="btn btn-primary" onclick="accionProceso(2)">Modificar</button>
                            <button type="button" id="btnBorrar" class="btn btn-primary" onclick="accionProceso(3)">Borrar</button>
                        </div>
                    </div>
                </div>
            </div>
            <!------------------------ MODAL DETALLE ------------->
            <div class="modal fade" id="modalDetalleTraspaso" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
                <div class="modal-dialog modal-lg" style="font-size: small;" role="document">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: powderblue">
                            <h5 class="modal-title" id="modalFormTittle">Detalles de Traspaso</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body" style="height: 500px; overflow: scroll;">
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Articulo : </label>
                                        <input type="hidden" id="txtIdTraspaso">
                                        <input type="hidden" id="txtIdDepositoOrigen">
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
                            </div>
                            <button class="btn btn-sm btn-info" 
                                    onclick="if ($('#cantidadArticulo').val() == '') {
                                                alert('Ingrese la cantidad !');
                                            } else {
                                                accionProcesoDetalleTraspaso(1)
                                            }">Insertar</button>
                            <button class="btn btn-sm btn-info" onclick="limpiarCampoDetalle()">Limpiar</button>
                            <label style="display: none" id="sucess" class="alert alert-success">Operacion Realizada !</label>
                            <label style="display: none" id="error"  class="alert alert-warning">No se pudo realizar la operacion !</label>
                            <label style="display: none" id="sucessArt" class="alert alert-success">Se actualizo el costo del articulo !</label>
                            <label style="display: none" id="errorArt"  class="alert alert-warning">No se pudo realizar la actualizacion del costo del articulo !</label><hr/>
                            <table id="tblArticuloTraspaso" style="font-size: small;" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
                                <thead class="table-primary">
                                <th>ARTICULO</th>
                                <th>CANTIDAD A TRANSFERIR</th>
                                <th>BORRAR</th>
                                </thead>
                                <tbody id="cuerpoArticuloTraspasos"></tbody>
                            </table><hr>
                            <button class="btn btn-primary" onclick="finiquitarTraspasoImprimir()">PROCESAR TRASPASO</button>
                            <button class="btn btn-primary" id="btnCancelTraspaso" style="display: none" data-dismiss="modal">CANCELAR</button>
                        </div>
                    </div>
                </div>
            </div>
    </body>
    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/jquery-ui-1.9.1.custom.js"></script>
    <script src="js/toastr.min.js"></script>
    <script src="js/datatables.min.js"></script>
    <script src="js-sistema/traspaso.js"></script>
</html>
