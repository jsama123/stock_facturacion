<%-- 
    Document   : StockHome
    Created on : 24/06/2020, 05:30:10 PM
    Author     : Jose Samaniego
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="ChequearSesion.jsp" %>
        <link href="css/datatables.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
        <link href="css/toastr.min.css" rel="stylesheet">
        <style>
            body {
                padding-top: 50px;
                padding-left: 10px
            }
        </style>
        <title>Stock</title>
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
        <h4>Inventariar Articulos</h4>
        <div class="form-inline">
            <label>Seleccione el deposito :  </label>
            <select id="cmbDeposito" class="form-control form-control-sm"></select>
        </div><br>
        <div class="form-inline">
            <label>Seleccione los articulos a visualizar :  </label>
            <select id="cmbArticulos" class="form-control form-control-sm">
                <option value="2">Articulos Inventariados</option>
                <option value="3">Articulos No Inventariados</option>
            </select>
        </div><hr>
        <table id="tblArticulos" style="font-size: 11px" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
            <thead class="table-primary">
            <th><input type="checkbox" id="chkSeleccionArticulos" onclick="checkear('Articulos')" style="margin-top: 0px;background-color: transparent"/> </th>
            <th>ID</th>
            <th>ARTICULO</th>
            <th id="thMinimo">CANT MINIMA</th>
            <th id="thMaximo">CANT MAXIMA</th>
            <th>COSTO DE COMPRA</th>
            <th>COSTO DE VENTA</th>
        </thead>
        <tbody id="cuerpoArticulos">

        </tbody>
        <tfoot id="tfootArticulo2">
            <tr>
                <th colspan="6">
                    <input type="button" style="display: none" class="btn btn-primary" onclick="procesarAccion(1)" value="Insertar" id="btnInsert" >
                    <input type="button" style="display: none" class="btn btn-primary" onclick="procesarAccion(2)" value="Modificar" id="btnUpdate" >
                    <input type="button" style="display: none" class="btn btn-primary" onclick="procesarAccion(3)" value="Borrar"    id="btnDelete">
                </th>
            </tr>
        </tfoot>
        <tfoot id="tfootArticulo3" style="display: none">
            <tr>
                <th colspan="6">
                    <input type="button" class="btn btn-primary" onclick="procesarAccion(1)" value="Asignar">
                </th>
            </tr>
        </tfoot>
    </table>
    <script src="js-sistema/stock.js"></script>
    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/toastr.min.js"></script>
    <script src="js/datatables.min.js"></script>
</body>
</html>
