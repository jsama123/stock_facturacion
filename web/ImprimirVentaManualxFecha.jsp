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
        <h4>Imprimir Ventas Manuales por Fecha</h4><hr>
        <div class="form-inline">
            <label>Desde :</label>
            <input type="text" id="txtFechaDesde" name="camposForm" class="form-control" readonly="true">
        </div><br>
        <div class="form-inline">
            <label>Hasta :</label>
            <input type="text" id="txtFechaHasta" name="camposForm" class="form-control" readonly="true">
        </div>
        <button class="btn btn-sm btn-primary" onclick="imprimirReporte()">Imprimir</button>
        <button class="btn btn-sm btn-primary" onclick="imprimirReporteExcel()">Imprimir en Excel</button>
        <script src="js/jquery-3.4.1.min.js"></script>
        <script src="js/jquery-ui-1.9.1.custom.js"></script>
        <script type="text/javascript">
            $(document).ready(function(){
                $("#txtFechaDesde").datepicker({
                    dateFormat: 'yy-mm-dd'
                });
                $("#txtFechaHasta").datepicker({
                    dateFormat: 'yy-mm-dd'
                });
            });
            
            function imprimirReporte(){
                window.open("ReporteVentaManualxFecha.jsp?fecha_inicio=" + $("#txtFechaDesde").val()+"&fecha_fin="+$("#txtFechaHasta").val(), "_blank");
                //window.location.href = "ReporteArticuloxDeposito.jsp?id_deposito=" + $("#cmbDepositoImprm").val();
            }
            
            function imprimirReporteExcel(){
                //window.open("ReporteArticuloxDeposito.jsp?id_deposito=" + $("#cmbDepositoImprm").val(), "_blank");
                window.location.href = "ReporteVentaManualxFechaXLS.jsp?fecha_inicio=" + $("#txtFechaDesde").val()+"&fecha_fin="+$("#txtFechaHasta").val();
            }
        </script>
    </body>
</html>
