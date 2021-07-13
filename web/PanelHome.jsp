<%-- 
    Document   : PanelHome
    Created on : 24/07/2020, 01:04:48 AM
    Author     : Jose Samaniego
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="ChequearSesion.jsp" %>
        <style>
            body {
                padding-top: 50px;
                padding-left: 10px;
            }
        </style>
        <title>Panel</title>
    </head>
    <body>
        <div class="card" style="width: 100%;">
        <div class="form-inline">
            <h5>Ingrese mes y año : </h5>
            <input type="text" style="size: 250px" id="fechaDatos" placeholder="Ejemplo : 01/2021.." class="form-control" id="txtFechaDat">
            <button class="btn btn-default btn-sm" onclick="generarDatosIngreEgre()">Generar Datos</button>
            <label id="labelLoad" style="display: none">Generando...</label>
        </div><br>
        <div class="row" style="width: 70%">
            <div class="col">
                <h5 id="ingresosD" style="font-weight: bold"></h5><h5 id="ingresosD" style="font-weight: bold"></h5>
                <button class="btn btn-success btn-sm">INGRESOS</button>
            </div>
            <div class="col">
                <h5 id="egresosD" style="font-weight: bold"></h5>
                <button class="btn btn-danger btn-sm">EGRESOS</button>
            </div>
        </div><hr>
        <div class="row">
            <div class="col">
                <div class="card">
                    <div class="card-header">
                        <h5>Graficos estadisticos - Ingresos</h5>
                    </div>
                    <div class="card-body">
                        <canvas id="myChartIngresos"></canvas>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card">
                    <div class="card-header">
                        <h5>Graficos estadisticos - Egresos</h5>
                    </div>
                    <div class="card-body">
                        <canvas id="myChartEgresos"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript" src="charjs/Chart.js"></script>
        <script type="text/javascript">
                function generarDatosIngreEgre() {
                    $("#labelLoad").show();
                    generarDatosEgresos();
                    var resultado = $.ajax({
                        async: false,
                        cache: false,
                        url: 'PanelDatos.jsp',
                        type: 'POST',
                        data: {
                            opcion: 1,
                            fecha: $("#fechaDatos").val()
                        },
                        dataType: 'html',
                        success: function(datos) {
                            $("#ingresosD").text("Gs. " + datos);
                            $("#labelLoad").hide();
                        },
                        error: function() {
                            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
                            $("#labelLoad").hide();
                        }
                    });
                }

                function generarDatosEgresos() {
                    var resultado = $.ajax({
                        async: false,
                        cache: false,
                        url: 'PanelDatos.jsp',
                        type: 'POST',
                        data: {
                            opcion: 2,
                            fecha: $("#fechaDatos").val()
                        },
                        dataType: 'html',
                        success: function(datos) {
                            $("#egresosD").text("Gs. " + datos);
                        },
                        error: function() {
                            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
                        }
                    });
                }

                var ctx = document.getElementById('myChartIngresos').getContext('2d');
                var chart = new Chart(ctx, {
                    // The type of chart we want to create
                    type: 'bar', //tipos : bar
                    // The data for our dataset
                    data: {
                        labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
                        datasets: [{
                                label: 'Ingresos ultimos 6 meses',
                                backgroundColor: 'rgb(40, 241, 156)',
                                borderColor: 'rgb(255, 99, 132)',
                                data: [10000, 20000, 30000, 40000, 50000, 60000, 70000]
                            }]
                    },
                    // Configuration options go here
                    options: {}
                });
                var ctx2 = document.getElementById('myChartEgresos').getContext('2d');
                var chart2 = new Chart(ctx2, {
                    // The type of chart we want to create
                    type: 'bar', //tipos : bar
                    // The data for our dataset
                    data: {
                        labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
                        datasets: [{
                                label: 'Egresos ultimos 6 meses',
                                backgroundColor: 'rgb(255, 99, 132)',
                                borderColor: 'rgb(255, 99, 132)',
                                data: [10000, 20000, 30000, 40000, 50000, 60000, 70000]
                            }]
                    },
                    // Configuration options go here
                    options: {}
                });
        </script>
    </body>
</html>
