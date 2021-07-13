<%-- 
    Document   : MalogradoHome
    Created on : 3/06/2020, 07:35:17 PM
    Author     : Jose Samaniego
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/datatables.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
        <link href="css/toastr.min.css" rel="stylesheet">
        <%@include file="ChequearSesion.jsp" %>
        <style>
            body {
                padding-top: 50px;
                padding-left: 10px
            }
        </style>
        <title>Malogrado</title>
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
        <h4>Administrar Articulos Malogrados</h4>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3">
                    <button class="btn btn-info" onclick="abrirFormulario('insertar')" data-toggle="modal" data-target="#modalForm">Agregar Registro</button>
                </div>
            </div><br>
            <table id="tblMalogrados" style="font-size: small;" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
                <thead class="table-primary">
                    <tr>
                        <th>DEPOSITO</th>
                        <th>ARTICULO</th>
                        <th>CANTIDAD</th>
                        <th>MOTIVO</th>
                        <th>ESTADO</th>
                        <th>EDITAR</th>
                        <th>BORRAR</th>
                        <th>APROBAR</th>
                    </tr>
                </thead>
                <tbody id="cuerpoMalogrados" style="">

                </tbody>
            </table>
            <!----------------FORMULARIO -------------->
            <div class="modal fade" id="modalForm" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
                <div class="modal-dialog modal-lg" style="font-size: small;" role="document">
                    <div class="modal-content">
                        <div class="modal-header table-primary">
                            <h5 class="modal-title" id="modalFormTittle">Agregar un nuevo Registro / Malogrado</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body" style="font-size: small">
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Seleccione el Deposito :</label>
                                        <input type="hidden" id="txtId">
                                        <select id="cmbDepoAjus" class="form-control form-control-sm"></select>
                                    </div>
                                </div>
                                <div class="col">

                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Articulo : <span style="color: red">*</span></label>
                                        <datalist id="articulosAjustes"></datalist>
                                        <input type="text" id="txtArtAjustes" style="font-size: small" autocomplete="off" placeholder="Ingrese articulo a buscar.." list="articulosAjustes" name="camposForm" class="form-control">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Cantidad:</label><span style="color: red">*</span>
                                        <input type="text" id="txtCantidadMal" name="camposForm" class="form-control">
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label>Motivo:</label><span style="color: red">*</span>
                                        <textarea class="form-control" name="camposForm" id="txtMotivoMal"></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Observacion:</label>
                                        <textarea class="form-control" name="camposForm" id="txtObs"></textarea>
                                    </div>
                                </div>
                                <div class="col">
                                </div>
                            </div>
                            <div class="form-inline">
                                <label style="font-weight: bold">Los campos marcados con * son obligatorios !</label>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" id="btnCancelar" onclick="limpiarCampos()" data-dismiss="modal">Cancelar</button>
                            <button type="button" id="btnInsertar" class="btn btn-primary" onclick="if ($('#txtObsAjustes').val() == '') {
                                        alert('Debe ingresar una observacion / motivo !!');
                                    } else {
                                        accionProceso(1);
                                    }">Guardar</button>
                            <button type="button" id="btnModificar" class="btn btn-primary" onclick="accionProceso(2)">Modificar</button>
                            <button type="button" id="btnBorrar" class="btn btn-primary" onclick="accionProceso(3)">Borrar</button>
                        </div>
                    </div>
                </div>
            </div>
    </body>
    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/toastr.min.js"></script>
    <script src="js/datatables.min.js"></script>
    <script src="js-sistema/malogrado.js"></script>
</html>
