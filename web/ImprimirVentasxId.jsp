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
        <title>Imprimir Ventas</title>
        <%@include file="ChequearSesion.jsp" %>
        <style>
            body {
                padding-top: 50px;
                padding-left: 10px
            }
        </style>
    </head>
    <body>
        <h4>Impresion de Ventas</h4><hr>
        <div class="row">
            <div class="col">
                <div class="form-group">
                    <label>Ingrese el Nro de Comprobante a procesar : </label>
                    <datalist id="ventasList" style="width: 100%"></datalist>
                    <input type="text" id="txtVenta" style="font-size: small" autocomplete="off" placeholder="Ingrese nro de comprobante.." list="ventasList" name="camposForm" class="form-control">
                </div>
            </div>
        </div>
        <button class="btn btn-sm btn-primary" onclick="imprimirReporte()">Imprimir</button>
        <script src="js/jquery-3.4.1.min.js"></script>
        <script src="js/jquery-ui-1.9.1.custom.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                cargarDatos(1, "ventasList");
            });

            function imprimirReporte() {
                var valoresInputVenta, valoresInputVenta2, valoresInput, valoresInput2 = [];
                var id_venta, tipo;
                valoresInputVenta = $.trim($("#txtVenta").val()).split("|");
                valoresInput = $.trim(valoresInputVenta[0]).split(":");
                valoresInput2 = $.trim(valoresInputVenta[1]).split(":");
                id_venta = $.trim(valoresInput[1]);
                tipo = $.trim(valoresInput2[1]);
                console.log(tipo);
                if ($.trim(tipo) == "Ticket") {
                    window.open("ReporteVentaSimple.jsp?id_venta=" + id_venta, "_blank");
                } else {
                    window.open("ReporteTicketVenta.jsp?id_venta=" + id_venta, "_blank");
                }
                //window.location.href = "ReporteArticuloxDeposito.jsp?id_deposito=" + $("#cmbDepositoImprm").val();
            }

            /* function imprimirReporteExcel() {
             var valor = $("#chkFacImpr").is(":checked") ? '0' : '1';
             //window.open("ReporteArticuloxDeposito.jsp?id_deposito=" + $("#cmbDepositoImprm").val(), "_blank");
             window.location.href = "ReporteVentaxFechaXLS.jsp?fecha_inicio=" + $("#txtFechaDesde").val() + "&fecha_fin=" + $("#txtFechaHasta").val() + "&condicion=" + valor;
             }*/

            function cargarDatos(opcion, objeto, id) {
                var resultado = $.ajax({
                    async: false,
                    cache: false,
                    url: 'ObtenerDatosGenerico.jsp',
                    type: 'POST',
                    data: {
                        opcion: opcion,
                        id: id
                    },
                    dataType: 'html',
                    success: function(datos) {
                        $("#" + objeto).html($.trim(datos));
                        $("#cargando").hide();
                    },
                    error: function() {
                        alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
                    }
                });
            }
        </script>
    </body>
</html>
