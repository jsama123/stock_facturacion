<%-- 
    Document   : ParametroCuotaVentaHome
    Created on : 3/07/2020, 09:27:50 PM
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
        <%@include file="ChequearSesion.jsp" %>
        <style>
            body {
                padding-top: 50px;
                padding-left: 10px
            }
        </style>
        <title>ParametroCuotaVenta</title>
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
        <h4>Administrar Parametros Ventas Credito</h4>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3">
                    <button class="btn btn-info" onclick="abrirFormulario('insertar')" data-toggle="modal" data-target="#modalForm">Agregar Registro</button>
                </div>
            </div><br>
            <table id="tblParametroCuotaVentas" style="font-size: small;" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
                <thead class="table-primary">
                    <tr>
                        <th>ID</th>
                        <th>Cantida de Cuotas / Ventas Credito</th>
                        <th>Interes Mensual</th>
                        <th>EDITAR</th>
                        <th>BORRAR</th>
                    </tr>
                </thead>
                <tbody id="cuerpoParametroCuotaVentas" style="">

                </tbody>
            </table>
            <!----------------FORMULARIO -------------->
            <div class="modal fade" id="modalForm" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalFormTittle">Agregar un nuevo Registro / Parametro Cuota Venta</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Cantidad de Cuotas : <span style="color: red; font-weight: bold">*</span> </label>
                                        <input type="hidden" id="txtId">
                                        <input type="text" id="txtCantCuo" class="form-control" size="30px">
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label>Interes mensual: <span style="color: red; font-weight: bold">*</span> </label>
                                        <input type="text" id="txtInteresMensual" class="form-control" size="30px">
                                    </div>
                                </div>
                            </div>
                            <div class="form-inline">
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
    <script src="js/datatables.min.js"></script>
    <script src="js/toastr.min.js"></script>
    <script src="js-sistema/parametroCuotaVenta.js"></script>
</html>

