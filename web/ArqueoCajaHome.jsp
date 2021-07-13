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
        <h4>Administrar Arqueo de Caja</h4>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3">
                    <button class="btn btn-info" onclick="abrirFormulario('insertar')" data-toggle="modal" data-target="#modalForm">Agregar Registro</button>
                </div>
            </div><br>
            <table id="tblArqueoCaja" style="font-size: small;" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
                <thead class="table-primary">
                    <tr>
                        <th>CAJERO</th>
                        <th>CAJA</th>
                        <th>FECHA Y HORA INICIO</th>
                        <th>FECHA Y HORA FIN</th>
                        <th>ESTADO</th>
                        <th>RESULTADO</th>
                        <th>EDITAR</th>
                        <th>BORRAR</th>
                        <th>DETALLES DE CIERRE</th>
                        <th>IMPRIMIR</th>
                    </tr>
                </thead>
                <tbody id="cuerpoArqueoCaja" style="">

                </tbody>
            </table>
            <!----------------FORMULARIO -------------->
            <div class="modal fade" id="modalForm" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
                <div class="modal-dialog modal-lg" style="font-size: small;" role="document">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: powderblue">
                            <h5 class="modal-title" id="modalFormTittle">Agregar un nuevo Registro / Arqueo de Caja</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Cajero :  <span style="color: red; font-weight: bold">*</span></label>
                                        <input type="hidden" id="txtId">
                                        <select id="cmbCajero" name="cmb" class="form-control" style="font-size: small"></select>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label>Caja : </label>
                                        <select id="cmbCaja" class="form-control" name="cmb" style="font-size: small"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Saldo Inicial :  <span style="color: red; font-weight: bold">*</span></label>
                                        <input type="text" id="txtSaldo" name="camposForm" class="form-control" >
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
                                    onclick="if (validarArqueo() == 's') {
                                                alert('PARA REGISTRAR NUEVOS ARQUEOS DE CAJA DEBE CERRAR EL ARQUEO PENDIENTE !!');
                                            } else {
                                                accionProceso(1)
                                            }">Guardar</button>
                            <button type="button" id="btnModificar" class="btn btn-primary" onclick="accionProceso(2)">Modificar</button>
                            <button type="button" id="btnBorrar" class="btn btn-primary" onclick="accionProceso(3)">Borrar</button>
                        </div>
                    </div>
                </div>
            </div>
            <!----------------MODAL DETALLE ---------------------->
            <div class="modal fade" id="modalDetalleArqueo" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
                <div class="modal-dialog modal-lg" style="font-size: small;" role="document">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: powderblue">
                            <h5 class="modal-title" id="modalFormTittle">Detalles / Arqueo de Caja</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body" style="height: 500px; overflow: scroll">
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>Cantidad : </label>
                                        <input type="hidden" id="txtidArqueo">
                                        <input type="text" id="txtCantidadDetail" class="form-control form-control-sm">
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label>Denominacion : </label>
                                        <select id="cmbDenominacion" class="form-control" style="font-size: small">
                                            <option value="50">50</option><option value="100">100</option>
                                            <option value="500">500</option><option value="1000">1000</option>
                                            <option value="2000">2000</option><option value="5000">5000</option>
                                            <option value="10000">10000</option><option value="20000">20000</option>
                                            <option value="50000">50000</option><option value="100000">100000</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <button class="btn btn-sm btn-info" onclick="accionProcesoDetalle(1)">Insertar</button>
                            <button class="btn btn-sm btn-info">Limpiar</button>
                            <label style="display: none" id="sucess" class="alert alert-success">Operacion Realizada !</label>
                            <label style="display: none" id="error"  class="alert alert-warning">No se pudo realizar la operacion !</label><hr/>
                            <table id="tblDetalleArqueo" class="table table-striped table-bordered table-sm">
                                <thead class="table-primary">
                                    <tr>
                                        <th>Cantidad</th>
                                        <th>Denominacion</th>
                                        <th>Sub Total</th>
                                        <th>Borrar</th>
                                    </tr>
                                </thead>
                                <tbody id="cuerpoDetalleArqueo"></tbody>
                                <tfoot>
                                    <tr>
                                        <th style="text-align: right; font-weight: bold" colspan="2">Total General</th>
                                        <th id="thTotal" style="font-weight: bold"></th>
                                    </tr>
                                </tfoot>
                            </table>
                            <div class="form-inline">
                                <label>Observaciones de Cierre de Caja : </label>
                                <textarea id="txtObservacionCierre" class="form-control" size='500px'></textarea>
                            </div><hr>
                            <button class="btn btn-dark-green" onclick="if (validarVentasAbiertas() == 's') {
                                        alert('NO SE PUEDE CERRAR LA CAJA YA QUE EXISTEN VENTAS PENDIENTE DE PROCESAR !!');
                                    }
                                    else {
                                        accionProceso(4)
                                    }">CERRAR CAJA</button>
                            <button class="btn btn-primary" id="btnCancelArqueo" data-dismiss="modal">CANCELAR</button>
                        </div>
                    </div>
                </div>
            </div>
    </body>
    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/toastr.min.js"></script>
    <script src="js/datatables.min.js"></script>
    <script src="js/jquery-ui-1.9.1.custom.js"></script>
    <script src="js-sistema/arqueoCaja.js"></script>
</html>
