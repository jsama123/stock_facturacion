
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
    String nombre_archivo = "ReporteVentasdeArticulosConsolidado";
    String fecha_inicio = request.getParameter("fecha_inicio");
    String fecha_fin = request.getParameter("fecha_fin");
    String condicion = request.getParameter("condicion");
    ResultSet datosSolicitados = null;
    String sql = "";
    String sql1 = "";
    String html = "";
    sql = "SELECT "
            + "articulo_descripcion, "
            + "max(marca_descripcion) as marca, "
            + "max(medida_descripcion) as medida, "
            + "sum(vd.cantidad_venta) as cantidad_vendida, "
            + "max(costo_articulo)::int as costo_venta, "
            + "sum(vd.cantidad_venta)*max(costo_articulo)::int as sub_total,"
            + "max(vd.precio_unitario::int) as precio_venta, "
            + "sum(vd.cantidad_venta)*max(vd.precio_unitario)::int as sub_total_venta, "
            + "costo_compra::int as cost_compra, "
            + "sum(vd.cantidad_venta)*costo_compra::int as sub_total_compra "
            + "FROM stock_facturacion.ventas_detalles vd "
            + "LEFT JOIN stock_facturacion.ventas v on v.id_venta = vd.id_venta "
            + "LEFT JOIN stock_facturacion.stocks s on s.id_stock = vd.id_stock "
            + "LEFT JOIN stock_facturacion.articulo_costos c on c.id_articulo_costo = s.id_articulo_costo "
            + "LEFT JOIN stock_facturacion.articulos a on a.id_articulo = s.id_articulo "
            + "LEFT JOIN stock_facturacion.marcas m on m.id_marca = a.id_marca "
            + "LEFT JOIN stock_facturacion.medidas m1 on m1.id_medida = a.id_medida "
            + "WHERE fecha_venta::date >='" + fecha_inicio + "'::date AND fecha_venta::date<='" + fecha_fin + "'::date AND estado_venta = 1"
            + "GROUP BY articulo_descripcion, vd.precio_unitario, costo_compra "
            + "ORDER BY 1 asc";
    datosSolicitados = dataSource.obtenerDato(sql);

    while (datosSolicitados.next()) {
        html += "<tr>";
        html += "<td>" + datosSolicitados.getString("articulo_descripcion") + "</td>";
        html += "<td>" + datosSolicitados.getString("marca") + "</td>";
        html += "<td>" + datosSolicitados.getString("medida") + "</td>";
        html += "<td>" + datosSolicitados.getString("cantidad_vendida") + "</td>";
        html += "<td>" + datosSolicitados.getString("precio_venta") + "</td>";
        html += "<td>" + datosSolicitados.getString("sub_total_venta") + "</td>";
        html += "<td>" + datosSolicitados.getString("cost_compra") + "</td>";
        html += "<td>" + datosSolicitados.getString("sub_total_compra") + "</td>";
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
                        + "<tr><th colspan='8'>REPORTE DE VENTAS POR FECHA DE ARTICULOS CONSOLIDADO DESDE : " + fecha_inicio + " HASTA " + fecha_fin + "</th></tr>"
                        + "<tr>"
                        + "<th>ARTICULO</th>"
                        + "<th>MARCA</th>"
                        + "<th>MEDIDA</th>"
                        + "<th>CANTIDAD</th>"
                        + "<th>PRECIO VENTA</th>"
                        + "<th>SUB-TOTAL VENTA</th>"
                        + "<th>COSTO DE COMPRA</th>"
                        + "<th>SUB-TOTAL COMPRA</th>"
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

