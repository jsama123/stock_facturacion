<%-- 
    Document   : SucursalHome
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
        <title>Sucursal</title>
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
        <h4>Administrar Sucursales</h4>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3">
                    <button class="btn btn-info" onclick="abrirFormulario('insertar')" data-toggle="modal" data-target="#modalForm">Agregar Registro</button>
                </div>
        </div><br>
        <table id="tblSucursals" style="font-size: small;" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
            <thead class="table-primary">
                <tr>
                    <th>ID</th>
                    <th>DESCRIPCION</th>
                    <th>DIRECCION</th>
                    <th>EDITAR</th>
                    <th>BORRAR</th>
                </tr>
            </thead>
            <tbody id="cuerpoSucursals" style="">

            </tbody>
        </table>
        <!----------------FORMULARIO -------------->
        <div class="modal fade" id="modalForm" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
            <div class="modal-dialog modal-lg" style="font-size: small;" role="document">
                <div class="modal-content">
                    <div class="modal-header table-primary">
                        <h5 class="modal-title" id="modalFormTittle">Agregar un nuevo Registro / Sucursal</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label>Descripcion : <span style="color: red; font-weight: bold">*</span></label>
                                    <input type="hidden" id="txtId">
                                    <input type="text" id="txtDescripcion" name="camposForm" class="form-control" >
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label>Nro Telefono :</label>
                                    <input type="text" id="txtTelefono" name="camposForm" class="form-control">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label>Dirección : </label>
                                    <input type="text" id="txtDireccion" name="camposForm" class="form-control">
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label>Nro Sucursal : <span style="color: red; font-weight: bold">*</span> </label>
                                    <input type="text" id="txtNroSucursal" name="camposForm" class="form-control">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <label style="font-weight: bold">Los campos marcados con * son obligatorios !</label>
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
    <script src="js-sistema/sucursal.js"></script>
</html>
