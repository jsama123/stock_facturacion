
<%@page import="genericos.fuenteDatos"%>
<%@page import="genericos.Conexion"%>
<%@ page language='java' import='java.sql.*' %>
<%@page contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%//@ page language='java' import='java.sql.*' errorPage='Error.jsp' %>
<%@ include file='ChequearSesion.jsp' %>

<%    //CONEXION DE DATOS
    Conexion cn = new Conexion();
    fuenteDatos dataSource = new fuenteDatos();
    dataSource.setConexion(cn.getConexion());
    String nombre_archivo = "Reporte_Existencia_Gs_Deposito";
    String id_deposito = request.getParameter("id_deposito");
    ResultSet datosSolicitados = null;
    String sql = "";
    String sql1 = "";
    String html = "";
    sql = "SELECT DISTINCT "
            + "max(articulo_descripcion) as articulo_descripcion, "
            + "max(marca_descripcion) as marca_descripcion, "
            + "sum(existencia)::int as exis_actual, "
            + "max(costo_compra)::int as costo, "
            + "max(costo_compra)::int * sum(existencia)::int as sub_total "
            + "FROM stock_facturacion.stocks s "
            + "LEFT JOIN stock_facturacion.articulos a on a.id_articulo = s.id_articulo "
            + "LEFT JOIN stock_facturacion.articulo_costos ac on ac.id_articulo_costo = s.id_articulo_costo "
            + "LEFT JOIN stock_facturacion.marcas m on m.id_marca = a.id_marca "
            + "LEFT JOIN stock_facturacion.grupos g on g.id_grupo = a.id_grupo "
            + "LEFT JOIN stock_facturacion.depositos_sucursales d on d.id_deposito_sucursal = s.id_deposito_sucursal "
            + "WHERE s.existencia > 0 "
            + "GROUP BY s.id_articulo, ac.id_articulo_costo "
            + "ORDER BY 2, 1 asc";
    datosSolicitados = dataSource.obtenerDato(sql);

    while (datosSolicitados.next()) {
        html += "<tr>";
        html += "<td>" + datosSolicitados.getString("articulo_descripcion") + "</td>";
        html += "<td>" + datosSolicitados.getString("marca_descripcion") + "</td>";
        html += "<td>" + datosSolicitados.getString("exis_actual") + "</td>";
        html += "<td>" + datosSolicitados.getString("costo") + "</td>";
        html += "<td>" + datosSolicitados.getString("sub_total") + "</td>";
        html += "</tr>";
    }

    response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.
    response.setHeader("Content-Disposition", "attachment;filename=" + nombre_archivo + ".xls");
    //
%>

<style type="text/css">
    th{
        background-color: lightgray
    }
</style>
<html>
    <head>
        <title></title>
        <META http-equiv='Content-type' CONTENT='text/html; charset=UTF-8'/>
    </head>
    <body>
        <table border="1" >
            <%
                out.print("<thead>"
                        + "<tr><th colspan='5'>REPORTE DE EXISTENCIA DE ARTICULOS CONSOLIDADO</th></tr>"
                        + "<tr>"
                        + "<th>ARTICULO</th>"
                        + "<th>MARCA</th>"
                        + "<th>EXISTENCIA</th>"
                        + "<th>COSTO</th>"
                        + "<th>SUB-TOTAL</th>"
                        + "</tr>"
                        + "</thead>");
            %>
            <tbody>
                <%
                    out.print(html);
                    cn.desConectarBD();
                %>
            </tbody>
        </table>
    </body>
</html>

