<%-- 
    Document   : ArticuloHome
    Created on : 3/06/2020, 07:35:17 PM
    Author     : Jose Samaniego
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/datatables.min.css" rel="stylesheet">
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
        <h4>Etiquetar Articulos</h4>
        <table id="tblArticulos" style="font-size: small;" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
            <thead class="table-primary">
                <tr>
                    <th><input type="checkbox" id="chkSeleccionArticulos" style="margin-top: 0px;background-color: transparent"/></th>
                    <th>ITEM</th>
                    <th>ID</th>
                    <th>ARTICULO</th>
                    <th>CANTIDAD</th>
                </tr>
            </thead>
            <tbody id="cuerpoArticulos" style="">

            </tbody>
            <tfoot>
                <tr style="text-align: center">
                    <th colspan="5">
                        <button id="btnImprimirArticulos" title="Imprime el cod. de barra correspondiente de los articulos seleccionados." 
                                onclick='verificarEstadoCheck()'
                                class="btn btn-primary">Imprimir Codigos de Barra</button>
                    </th>
                </tr>
            </tfoot>
        </table>
        <form id="frmImprimirCodBarra" action="./ReporteCodigosBarras.pdf" method="post">
            <input type="hidden" id="ids_art_cant" name="ids_art_cant" value="" />
        </form>
    </body>
    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/datatables.min.js"></script>
    <script src="js/jquery-ui-1.9.1.custom.js"></script>
    <script src="js-sistema/etiquetaArticulo.js"></script>
</html>
