<%-- 
    Document   : TimbradoHome
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
        <link href="css/jquery-ui-1.9.1.custom.min.css" rel="stylesheet">
        <link href="css/toastr.min.css" rel="stylesheet">
        <%@include file="ChequearSesion.jsp" %>
        <style>
            body {
                padding-top: 50px;
                padding-left: 10px
            }
        </style>
        <title>Timbrado</title>
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
        <h4>Administrar Timbrados</h4>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3">
                    <button class="btn btn-info" onclick="abrirFormulario('insertar')" data-toggle="modal" data-target="#modalForm">Agregar Registro</button>
                </div>
            </div>
        </div><br>
        <table id="tblTimbrados" style="font-size: small;" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
            <thead class="table-primary">
                <tr>
                    <th>ID</th>
                    <th>NUMERACION</th>
                    <th>FECHA INICIO</th>
                    <th>FECHA FIN</th>
                    <th>ESTADO</th>
                    <th>EDITAR</th>
                    <th>BORRAR</th>
                </tr>
            </thead>
            <tbody id="cuerpoTimbrados" style="">

            </tbody>
        </table>
        <!----------------FORMULARIO -------------->
        <div class="modal fade" id="modalForm" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
            <div class="modal-dialog modal-lg" style="font-size: small;" role="document">
                <div class="modal-content">
                    <div class="modal-header table-primary">
                        <h5 class="modal-title" id="modalFormTittle">Agregar un nuevo Registro / Timbrado</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label>Fecha Inicio : <span style="color: red; font-weight: bold">*</span></label>
                                    <input type="hidden" id="txtId">
                                    <input type="text" id="txtFechaInicio" name="camposForm" class="form-control" readonly="true">
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label>Fecha Fin :</label>
                                    <input type="text" id="txtFechaFin" name="camposForm" class="form-control" readonly="true">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label>Numeracion Timbrado : </label>
                                    <input type="text" id="txtNumTimbrado" name="camposForm" class="form-control">
                                </div>
                            </div>
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
    </body>
    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/toastr.min.js"></script>
    <script src="js/datatables.min.js"></script>
    <script src="js/jquery-ui-1.9.1.custom.js"></script>
    <script src="js-sistema/timbrado.js"></script>
</html>
