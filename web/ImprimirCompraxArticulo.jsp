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
        <h4>Imprimir Compras por Articulo</h4><hr>
        <div class="col">
            <div class="form-group">
                <label>Articulo :</label>
                <datalist id="articulosV"></datalist>
                <input type="text" id="txtArtv" autocomplete="off" placeholder="Ingrese descripcion del articulo.." list="articulosV" name="camposForm" class="form-control">
            </div>
            
        </div>
        <button class="btn btn-sm btn-primary" onclick="imprimirReporte()">Imprimir</button>
        <script src="js/jquery-3.4.1.min.js"></script>
        <script src="js/jquery-ui-1.9.1.custom.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                cargarDatos(2, "articulosV");
            });

            function imprimirReporte() {
                var id_articulo;
                var campos, campos2;
                campos = $.trim($("#txtArtv").val()).split("|");
                campos2 = $.trim(campos[0]).split(":");
                id_articulo = campos2[1];
                window.open("ReporteCompraxArticulo.jsp?id_articulo=" + id_articulo, "_blank");
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
