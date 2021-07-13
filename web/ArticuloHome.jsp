<%-- 
    Document   : ArticuloHome
    Created on : 3/06/2020, 07:35:17 PM
    Author     : Jose Samaniego
--%>

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
        <h4>Administrar Articulos</h4>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3">
                    <button class="btn btn-info" onclick="abrirFormulario('insertar')" data-toggle="modal" data-target="#modalForm">Agregar Registro</button>
                </div>
            </div><br>
            <table id="tblArticulos" style="font-size: small;" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
                <thead class="table-primary">
                    <tr>
                        <th>ID</th>
                        <th>MARCA</th>
                        <th>GRUPO</th>
                        <th>DESCRIPCION</th>
                        <th>AGREGAR FOTOS</th>
                        <th>ADMINISTRAR COSTOS</th>
                        <th>EDITAR</th>
                        <th>BORRAR</th>
                    </tr>
                </thead>
                <tbody id="cuerpoArticulos" style="">

                </tbody>
            </table>
            <!----------------FORMULARIO -------------->
            <div class="modal fade" id="modalForm" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
                <div class="modal-dialog modal-lg" style="font-size: small;" role="document">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: powderblue">
                            <h5 class="modal-title" id="modalFormTittle">Agregar un nuevo Registro / Articulo</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Descripcion :  <span style="color: red; font-weight: bold">*</span></label>
                                        <input type="hidden" id="txtId">
                                        <input type="text" id="txtDescripcion" name="camposForm" class="form-control" >
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label>Marca : </label>
                                        <select id="cmbMarca" class="form-control" name="cmb" style="font-size: small"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Grupo:</label>
                                        <select id="cmbGrupo" class="form-control" name="cmb" style="font-size: small"></select>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label>Medida : </label>
                                        <select id="cmbMedida" class="form-control" name="cmb" style="font-size: small"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Fecha Vencimiento : </label>
                                        <input type="text" id="txtFecha" name="camposForm" class="form-control" readonly="true">
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label>Codigo de Barra : </label>
                                        <input type="text" id="txtCodigoBarra" name="camposForm" class="form-control">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Impuesto : </label>
                                        <select id="cmbImpuesto" class="form-control" name="cmb" style="font-size: small"></select>
                                    </div>
                                </div>
                                <div class="col">
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
            <!--------------------- ANEXAR IMAGENES  ---------------------->
            <div class="modal fade" id="modalImagenes" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
                <div class="modal-dialog" style="font-size: small;" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h6>Anexar Imagen : <span id="spArt"></span> </h6>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button><br>
                        </div>
                        <div class="modal-body" style="height: 300px; overflow: scroll">
                            <div class="container-fluid">
                                <input type="hidden" id="txtIdArt">
                                <input type="file">
                                <input type="button" class="btn btn-primary btn-sm" value="Subir">
                                <input type="button" class="btn btn-info btn-sm" value="Limpiar">
                            </div><br>
                            <table id="tblImagenes" class="table table-sm">
                                <thead class="table-primary">
                                <th>ID</th>
                                <th>DESCRIPCION IMAGEN</th>
                                <th>ELIMINAR</th>
                                <th>VER</th>
                                </thead>
                                <tbody id="cuerpoImagenes"></tbody>
                            </table>
                        </div>
                        <div class="modal-footer">

                        </div>
                    </div>
                </div>
            </div>
            <!------------------------ MODAL DETALLE ------------->
            <div class="modal fade" id="modalDetalleArticulo" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
                <div class="modal-dialog modal-lg" style="font-size: small;" role="document">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: powderblue">
                            <h5 class="modal-title" id="modalFormTittle">Costos de Articulo</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body" style="height: 500px; overflow: scroll;">
                            <div class="row">
                                <div class="col">
                                    <h6>Articulo : <span id="spDescriArt" style="font-weight: bold"></span></h6>
                                </div>
                            </div><hr>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Costo de Compra : </label>
                                        <input type="hidden" id="idArtCosto">
                                        <input type="hidden" id="idArt">
                                        <input type="text" id="costoCompra" name="camposFormDetalle" size="40px" autocomplete="off" class="form-control form-control-sm">
                                    </div>
                                </div>
                                <div class="col">
                                    <label>Costo de Venta : </label>
                                    <input type="text" id="costoVenta" name="camposFormDetalle" size="40px" autocomplete="off" class="form-control form-control-sm">
                                </div>
                            </div>
                            <button id="btnInsertArt" class="btn btn-sm btn-info" 
                                    onclick="if ($('#costoCompra').val() == '' || $('#costoVenta').val() == '') {
                                                alert('Ingrese la cantidad !');
                                            } else {
                                                accionProcesoDetalleArticulo(1)
                                            }">Insertar</button>
                            <button id="btnModArt" style="display: none" class="btn btn-sm btn-info" onclick="accionProcesoDetalleArticulo(2, $('#idArtCosto').val());">Modificar</button>
                            <button class="btn btn-sm btn-info" onclick="limpiarCampoDetalle()">Limpiar</button>
                            <label style="display: none" id="sucess" class="alert alert-success">Operacion Realizada !</label>
                            <label style="display: none" id="error"  class="alert alert-warning">No se pudo realizar la operacion !</label>
                            <table id="tblArticuloCosto" style="font-size: small;" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
                                <thead class="table-primary">
                                <th>COSTO DE COMPRA</th>
                                <th>COSTO DE VENTA</th>
                                <th>EDITAR</th>
                                <th>BORRAR</th>
                                </thead>
                                <tbody id="cuerpoArticuloCosto"></tbody>
                            </table><hr>
                            <button class="btn btn-primary" id="btnCancelArticulo" style="display: none" data-dismiss="modal">CANCELAR</button>
                        </div>
                    </div>
                </div>
            </div>
    </body>
    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/toastr.min.js"></script>
    <script src="js/datatables.min.js"></script>
    <script src="js/jquery-ui-1.9.1.custom.js"></script>
    <script src="js-sistema/articulo.js"></script>
</html>
