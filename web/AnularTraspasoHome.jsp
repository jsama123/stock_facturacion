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
        <title>Anulacion</title>
        <%@include file="ChequearSesion.jsp" %>
        <style>
            body {
                padding-top: 50px;
                padding-left: 10px
            }
        </style>
    </head>
    <body>
        <h4>Anulaciones de Traspasos</h4><hr>
        <div class="col">
            <div class="form-group">
                <label>Registro de Traspaso a Anular :</label>
                <datalist id="traspasoProcess"></datalist>
                <input type="text" id="txtTraspasoProcess" autocomplete="off" placeholder="Ingrese nro factura de compra a anular.." list="traspasoProcess" name="camposForm" class="form-control">
            </div>

        </div>
        <div class="row">
            <div  class="col">
                <div style="height: 250px; overflow: scroll" class="form-group">
                    <label>Detalles de Traspaso : </label>
                    <table id="tblItemsTraspaso" class="table table-striped table-bordered table-sm">
                        <thead style="font-size: x-small">
                        <th>Articulo</th>
                        <th>Cantidad Traspasada</th>
                        </thead>
                        <tbody style="font-size: x-small" id="cuerpoImtesTraspaso">

                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col"></div>
        </div>
        <button class="btn btn-sm btn-primary" onclick="anular()">Anular</button>
        <script src="js/jquery-3.4.1.min.js"></script>
        <script src="js/jquery-ui-1.9.1.custom.js"></script>
        <script src="js/toastr.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                cargarDatos(6, "traspasoProcess");

                $("#txtTraspasoProcess").change(function() {
                    var camposNotaVentas, valores = [];
                    var id;
                    camposNotaVentas = $.trim($(this).val()).split("|");
                    valores = $.trim(camposNotaVentas[0]).split(":");
                    id = $.trim(valores[1]);

                    cargarDatos(7, "cuerpoImtesTraspaso", id);
                });
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

            function anular() {
                var id;
                var campos, valores3;
                campos = $.trim($("#txtTraspasoProcess").val()).split("|");
                valores3 = $.trim(campos[0]).split(":");
                id = $.trim(valores3[1]);
                //id = campos[0];
                $.ajax({
                    async: false,
                    cache: false,
                    url: "TraspasoAnulacionControl",
                    type: 'POST',
                    data: {
                        id: id
                    },
                    dataType: 'html',
                    success: function(data, textStatus, jqXHR) {
                        if ($.trim(data) == "bien") {
                            toastr.success("Traspaso Anulada", "Notificación", {
                                "progressBar": true,
                                "positionClass": "toast-top-center",
                                "timeOut": "2000"
                            });
                        } else {
                            toastr.error("No se pudo anular la compra", "Notificación", {
                                "progressBar": true,
                                "positionClass": "toast-top-center",
                                "timeOut": "2000"
                            });
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) {

                    }
                });
                $("#txtTraspasoProcess").val("");
                cargarDatos(6, "traspasoProcess");
            }
        </script>
    </body>
</html>
