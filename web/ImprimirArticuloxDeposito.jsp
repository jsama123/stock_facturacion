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
        <h4>Imprimir Existencia de Articulos por Deposito</h4><hr>
        <div class="form-inline">
            <label>Seleccion el Deposito :</label>
            <select id="cmbDepositoImprm" class="form-control form-control-sm"></select>
        </div>
        <button class="btn btn-sm btn-primary" onclick="imprimirReporte()">Imprimir en PDF</button>
        <button class="btn btn-sm btn-primary" onclick="imprimirReporteExcel()">Imprimir en EXCEL</button>
        <script src="js/jquery-3.4.1.min.js"></script>
        <script src="js-sistema/stock.js"></script>
        <script type="text/javascript">
            $(document).ready(function(){
                cargarDatos(1, "cmbDepositoImprm");
            });
            
            function imprimirReporte(){
                window.open("ReporteArticuloxDeposito.jsp?id_deposito=" + $("#cmbDepositoImprm").val(), "_blank");
                //window.location.href = "ReporteArticuloxDeposito.jsp?id_deposito=" + $("#cmbDepositoImprm").val();
            }
            
            function imprimirReporteExcel(){
                //window.open("ReporteArticuloxDeposito.jsp?id_deposito=" + $("#cmbDepositoImprm").val(), "_blank");
                window.location.href = "ReporteExistenciaXLS.jsp?id_deposito=" + $("#cmbDepositoImprm").val();
            }
        </script>
    </body>
</html>
