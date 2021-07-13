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
        <link href="css/toastr.min.css" rel="stylesheet">
        <title>Imprimir Articulos por Deposito</title>
        <%@include file="ChequearSesion.jsp" %>
        <style>
            body {
                padding-top: 50px;
                padding-left: 10px
            }
        </style>
    </head>
    <body>
        <h4>Anulaciones de Ajustes de Existencias</h4><hr>
        <div class="col">
            <div class="form-group">
                <label>Registro de Ajuste a Anular :</label>
                <datalist id="ajusteProcess"></datalist>
                <input type="text" id="txtAjusteProcess" autocomplete="off" placeholder="Ingrese nro factura de compra a anular.." list="ajusteProcess" name="camposForm" class="form-control">
            </div>

        </div>
        <button class="btn btn-sm btn-primary" onclick="anular()">Anular</button>
        <script src="js/jquery-3.4.1.min.js"></script>
        <script src="js/jquery-ui-1.9.1.custom.js"></script>
        <script src="js/toastr.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                cargarDatos(3, "ajusteProcess");
            });

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
                        opcion: 4,
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

            function anular() {
                var id;
                var campos, valores3;
                campos = $.trim($("#txtAjusteProcess").val()).split("|");
                valores3 = $.trim(campos[0]).split(":");
                id = $.trim(valores3[1]);
                //id = campos[0];
                $.ajax({
                    async: false,
                    cache: false,
                    url: "AjustesStockControl",
                    type: 'POST',
                    data: {
                        opcion: 5,
                        id: id
                    },
                    dataType: 'html',
                    success: function(data, textStatus, jqXHR) {
                        if ($.trim(data) == "bien") {
                            toastr.success("Ajuste Anulada", "Notificación", {
                                "progressBar": true,
                                "positionClass": "toast-top-center",
                                "timeOut": "2000"
                            });
                        } else {
                            toastr.error("No se pudo anular el ajuste", "Notificación", {
                                "progressBar": true,
                                "positionClass": "toast-top-center",
                                "timeOut": "2000"
                            });
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) {

                    }
                });
                $("#txtAjusteProcess").val("");
                cargarDatos(3, "ajusteProcess");
            }
        </script>
    </body>
</html>
