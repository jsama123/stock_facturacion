<%-- 
    Document   : GastoHome
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
        <title>Gasto</title>
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
        <h4>Administrar Gastos</h4>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3">
                    <button class="btn btn-info" onclick="abrirFormulario('insertar')" data-toggle="modal" data-target="#modalForm">Agregar Registro</button>
                </div>
            </div><br>
            <table id="tblGastos" style="font-size: small;" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
                <thead class="table-primary">
                    <tr>
                        <th>PROVEEDOR</th>
                        <th>FECHA GASTO</th>
                        <th>CONCEPTO GASTO</th>
                        <th>NRO COMPROBANTE GASTO</th>
                        <th>MONTO GASTO</th>
                        <th>EDITAR</th>
                        <th>BORRAR</th>
                    </tr>
                </thead>
                <tbody id="cuerpoGastos" style="">

                </tbody>
            </table>
            <!----------------FORMULARIO -------------->
            <div class="modal fade" id="modalForm" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
                <div class="modal-dialog modal-lg" style="font-size: small;" role="document">
                    <div class="modal-content">
                        <div class="modal-header table-primary">
                            <h5 class="modal-title" id="modalFormTittle">Agregar un nuevo Registro / Gasto</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body" style="font-size: small">
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Proveedor :</label>
                                        <input type="hidden" id="txtId">
                                        <datalist id="proveedoresGasto"></datalist>
                                        <input type="text" id="txtProveedorGasto" autocomplete="off" placeholder="Ingrese ruc del proveedor.." list="proveedoresGasto" name="camposForm" class="form-control">
                                        <label style="font-size: small"><a href="#" data-toggle='modal' data-target='#modalAgregarProveedor'>Agregar Proveedor</a></label>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label>Monto Gasto (IVA incluido) <span style="color: red; font-weight: bold">*</span> </label>
                                        <input type="text" id="txtMontoGasto" name="camposForm" class="form-control" >
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Nro Comprobante Gasto:<span style="color: red; font-weight: bold">*</span> </label>
                                        <input type="text" id="txtNroCompGasto" name="camposForm" class="form-control">
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label>Concepto Gasto : <span style="color: red; font-weight: bold">*</span> </label>
                                        <textarea id="txtConcepGasto" name="camposForm" class="form-control"></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Iva a aplicar:<span style="color: red; font-weight: bold">*</span> </label>
                                        <select class="form-control" id="cmbIvaGasto">
                                            <option value="0">0</option>
                                            <option value="5">5</option>
                                            <option value="10">10</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label>Fecha Gasto : <span style="color: red; font-weight: bold">*</span> </label>
                                        <input type="text" id="txtFechaGasto" name="camposForm" class="form-control" readonly="true">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <label>Timbrado Gasto : <span style="color: red; font-weight: bold">*</span> </label>
                                    <input type="text" id="txtTimbradoGastos" name="camposForm" class="form-control">
                                </div>
                                <div class="col">
                                    <label>Tipo Gasto <span style="color: red; font-weight: bold">*</span> </label>
                                    <select class="form-control" id="cmbTipoGasto">
                                        <option value="CON">CONTADO</option>
                                        <option value="CRE">CREDITO</option>S
                                    </select>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <label>Cuota Gasto : <span style="color: red; font-weight: bold">*</span> </label>
                                    <input type="text" id="txtCuotaGastos" name="camposForm" class="form-control">
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
                            <button type="button" id="btnInsertar" class="btn btn-primary" onclick="accionProceso(1)">Guardar</button>
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
    </body>
    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/toastr.min.js"></script>
    <script src="js/datatables.min.js"></script>
    <script src="js/jquery-ui-1.9.1.custom.js"></script>
    <script src="js-sistema/gasto.js"></script>
</html>
