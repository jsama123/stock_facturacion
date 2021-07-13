<%-- 
    Document   : NotaPresupuestoHome
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
        <title>Nota de Presupuesto</title>
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
        <h4>Administrar Nota de Presupuestos</h4>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3">
                    <button class="btn btn-info" onclick="abrirFormulario('insertar')" data-toggle="modal" data-target="#modalForm">Agregar Registro</button>
                </div>
            </div><br>
            <table id="tblNotaPresupuestos" style="font-size: small;" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
                <thead class="table-primary">
                    <tr>
                        <th>FECHA NOTA</th>
                        <th>NRO NOTA</th>
                        <th>CLIENTE</th>                        
                        <th>EDITAR</th>
                        <th>BORRAR</th>
                        <th>DETALLES</th>
                        <th>IMPRIMIR</th>
                    </tr>
                </thead>
                <tbody id="cuerpoNotaPresupuestos" style="">

                </tbody>
            </table>
            <!----------------FORMULARIO -------------->
            <div class="modal fade" id="modalForm" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
                <div class="modal-dialog modal-lg" style="font-size: small;" role="document">
                    <div class="modal-content">
                        <div class="modal-header table-primary">
                            <h5 class="modal-title" id="modalFormTittle">Agregar un nuevo Registro / Nota de Presupuesto</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Cliente : <span style="color: red; font-weight: bold">*</span></label>
                                        <input type="hidden" id="txtIdNP">
                                        <datalist id="clientesNP"></datalist>
                                        <input type="text" id="txtClienteNP" autocomplete="off" placeholder="Ingrese ruc del cliente.." list="clientesNP" name="camposForm" class="form-control">
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label>Fecha Nota Presupuesto : <span style="color: red; font-weight: bold">*</span></label>
                                        <input type="text" id="txtFechaNotaPresupuesto" name="camposForm" class="form-control" readonly="true">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Observacion Nota Presupuesto : <span style="color: red; font-weight: bold">*</span></label>
                                        <textarea id="txtObsNP" class="form-control"></textarea>
                                    </div>
                                </div>
                                <div class="col">
                                    <label style="font-weight: bold">Los articulos marcados con * son obligatorios !</label>
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
            <!------------------------ MODAL DETALLE ------------->
            <div class="modal fade" id="modalDetalleNotaPresupuesto" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
                <div class="modal-dialog modal-lg" style="font-size: small;" role="document">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: powderblue">
                            <h5 class="modal-title" id="modalFormTittle">Detalles de NotaPresupuesto</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body" style="height: 500px; overflow: scroll;">
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Articulo : </label>
                                        <input type="hidden" id="txtIdNotaPresupuesto">
                                        <datalist id="articulosNP"></datalist>
                                        <input type="text" id="txtArticuloNP" name="camposFormDetalle" style="font-size: small" placeholder="Ingrese el articulo a buscar.." autocomplete="off" list="articulosNP" class="form-control form-control-sm">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Cantidad : </label>
                                        <input type="text" id="cantidadArticuloNP" name="camposFormDetalle" size="40px" autocomplete="off" class="form-control form-control-sm">
                                    </div>
                                </div>
                                <div class="col">
                                    <label>Descuento a Aplicar : </label>
                                    <select id="cmbDescNP" class="form-control form-control-sm"></select>
                                </div>
                            </div>
                            <input type="checkbox" id="checkNewCosto"><label> Marque si desea ingresar un nuevo costo del articulo </label><br>
                            <button class="btn btn-sm btn-info" 
                                    onclick="if ($('#cantidadArticulo').val() == '') {
                                                alert('Ingrese la cantidad !');
                                            } else {
                                                accionProcesoDetalleNotaPresupuesto(1)
                                            }">Insertar</button>
                            <button class="btn btn-sm btn-info" onclick="limpiarCampoDetalle()">Limpiar</button>
                            <label style="display: none" id="sucess" class="alert alert-success">Operacion Realizada !</label>
                            <label style="display: none" id="error"  class="alert alert-warning">No se pudo realizar la operacion !</label>
                            <label style="display: none" id="sucessArt" class="alert alert-success">Se actualizo el costo del articulo !</label>
                            <label style="display: none" id="errorArt"  class="alert alert-warning">No se pudo realizar la actualizacion del costo del articulo !</label><hr/>
                            <table id="tblArticuloNotaPresupuestos" style="font-size: small;" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
                                <thead class="table-primary">
                                <th>ARTICULO</th>
                                <th>CANTIDAD</th>
                                <th>PRECIO</th>
                                <th>SUB-TOTAL</th>
                                <th>BORRAR</th>
                                </thead>
                                <tbody id="cuerpoArticuloNotaPresupuestoss"></tbody>
                                <tfoot>
                                    <tr>
                                        <th colspan="3" style="font-weight: bold; text-align: right">TOTAL</th>
                                        <th id="thTotalNotaPresupuesto" colspan="2" style="font-weight: bold"></th>
                                    </tr>
                                </tfoot>
                            </table><hr>
                            <button class="btn btn-primary" id="btnCancelNotaPresupuesto" style="display: none" data-dismiss="modal">CANCELAR</button>
                        </div>
                    </div>
                </div>
            </div>
    </body>
    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/jquery-ui-1.9.1.custom.js"></script>
    <script src="js/toastr.min.js"></script>
    <script src="js/datatables.min.js"></script>
    <script src="js-sistema/notaPresupuesto.js"></script>
</html>
