<%-- 
    Document   : ImprimirArticuloxDeposito
    Created on : 7/07/2020, 01:10:57 AM
    Author     : Jose Samaniego
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/jquery-ui-1.9.1.custom.min.css" rel="stylesheet">
        <title>Anulacion de Compras</title>
        <%@include file="ChequearSesion.jsp" %>
        <style>
            body {
                padding-top: 50px;
                padding-left: 10px
            }
        </style>
    </head>
    <body>
        <h4>Anular Compras</h4><hr>
        <div class="row">
            <div class="col">
                <div class="form-group">
                    <label>Ingrese el Nro de factura de Compra a Anular : </label>
                    <input type="hidden" id="txtIdNotaCabecera">
                    <input type="hidden" id="txtConceptoNota">
                    <datalist id="compraList"></datalist>
                    <input type="text" id="txtCompraAnular" style="font-size: small" autocomplete="off" placeholder="Ingrese nro de comprobante.." list="compraList" name="camposForm" class="form-control">
                </div>
            </div>
            <div class="col">
                <div class="form-group">
                    <label>Motivo de Anulacion:</label>
                    <textarea class="form-control form-control-sm" id="txtMotivoAnulacion"></textarea>
                </div>
            </div>
        </div>
        <div class="row">
            <div  class="col">
                <div style="height: 250px; overflow: scroll" class="form-group">
                    <table id="tblItemsCompraAnular" class="table table-striped table-bordered table-sm">
                        <thead style="font-size: x-small">
                        <th>Articulo</th>
                        <th>Cantidad</th>
                        <th>Costo</th>
                        <th>Sub-Total</th>
                        </thead>
                        <tbody style="font-size: x-small" id="cuerpoImtesCompraAnular">

                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col">

            </div>
        </div>
        <button class="btn btn-sm btn-primary" onclick="imprimirReporte()">ANULAR</button>
        <script src="js/jquery-3.4.1.min.js"></script>
        <script src="js/jquery-ui-1.9.1.custom.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                cargarDatos(1, "compraList");
                $("#txtCompraAnular").change(function () {
                    var camposNotaVentas, valores = [];
                    var id_compra;
                    var montoTotalNota = 0;
                    camposNotaVentas = $.trim($(this).val()).split("|");
                    valores = $.trim(camposNotaVentas[0]).split(":");
                    id_compra = $.trim(valores[1]);

                    cargarDatos(2, "cuerpoImtesCompraAnular", id_compra);
                });
            });

            function imprimirReporte() {
                window.open("ReporteCompraxFecha.jsp?fecha_inicio=" + $("#txtFechaDesde").val() + "&fecha_fin=" + $("#txtFechaHasta").val(), "_blank");
                //window.location.href = "ReporteArticuloxDeposito.jsp?id_deposito=" + $("#cmbDepositoImprm").val();
            }

            function imprimirReporteExcel() {
                //window.open("ReporteArticuloxDeposito.jsp?id_deposito=" + $("#cmbDepositoImprm").val(), "_blank");
                window.location.href = "ReporteExistenciaXLS.jsp?id_deposito=" + $("#cmbDepositoImprm").val();
            }

            function cargarDatos(opcion, objeto, id) {
                var resultado = $.ajax({
                    async: false,
                    cache: false,
                    url: 'AnularCompraDatos.jsp',
                    type: 'POST',
                    data: {
                        opcion: opcion,
                        id: id
                    },
                    dataType: 'html',
                    success: function (datos) {
                        $("#" + objeto).html($.trim(datos));
                        $("#cargando").hide();
                    },
                    error: function () {
                        alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
                    }
                });
            }
        </script>
    </body>
</html>
