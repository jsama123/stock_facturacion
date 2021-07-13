
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
    String nombre_archivo = "Catalogo de Articulos";
    String id_deposito = request.getParameter("id_deposito");
    ResultSet datosSolicitados = null;
    String sql = "";
    String sql1 = "";
    String html = "";
    sql = "SELECT DISTINCT "
            + "articulo_descripcion, "
            + "max(marca_descripcion) as marca_descripcion, "
            + "max(COALESCE(costo_venta, 0))::int as precio "
            + "FROM stock_facturacion.articulos a "
            + "LEFT JOIN stock_facturacion.articulo_costos c on c.id_articulo = a.id_articulo "
            + "LEFT JOIN stock_facturacion.grupos g on g.id_grupo = a.id_grupo "
            + "LEFT JOIN stock_facturacion.marcas m on m.id_marca = a.id_marca "
            + "GROUP BY articulo_descripcion "
            + "ORDER BY marca_descripcion, articulo_descripcion asc";
    datosSolicitados = dataSource.obtenerDato(sql);

    while (datosSolicitados.next()) {
        html += "<tr>";
        html += "<td>" + datosSolicitados.getString("articulo_descripcion") + "</td>";
        html += "<td>" + datosSolicitados.getString("marca_descripcion") + "</td>";
        html += "<td>" + datosSolicitados.getString("precio") + "</td>";
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
                        + "<tr><th colspan='3'>CATALOGO DE ARTICULOS</th></tr>"
                        + "<tr>"
                        + "<th>ARTICULO</th>"
                        + "<th>MARCA</th>"
                        + "<th>PRECIO DE VENTA</th>"
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

