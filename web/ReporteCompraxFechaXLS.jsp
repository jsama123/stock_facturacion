
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
    String nombre_archivo = "Reporte_Compras_x_Fecha";
    String fecha_inicio = request.getParameter("fecha_inicio");
    String fecha_fin = request.getParameter("fecha_fin");
    ResultSet datosSolicitados = null;
    String sql = "";
    String html = "";
    sql = "SELECT "
            + "v.id_compra, "
            + "COALESCE(nro_factura_compra, '--') as nro_factura_compra, "
            + "nombre_apellido_cajero as nombre_apellido_cajero, "
            + "to_char(fecha_compra, 'DD/MM/YYYY')as fecha, "
            + "iva_aplicado as iva_aplicado, "
            + "ci_ruc_proveedor as ci_ruc_proveedor, "
            + "razon_social_proveedor as razon_social_proveedor, "
            + "vd.id_stock as id_stock, "
            + "cantidad_compra as cantidad_compra, "
            + "costo_unitario::int as costo, "
            + "articulo_descripcion, "
            + "cantidad_compra*costo_unitario::int as sub_total,"
            + "(cantidad_compra*costo_unitario::int)*iva_aplicado/100 as iva_gs, "
            + "(cantidad_compra*costo_unitario::int)-((cantidad_compra*costo_unitario::int)*iva_aplicado/100) as subTotalIva "
            + "FROM stock_facturacion.compras_detalles vd "
            + "LEFT JOIN stock_facturacion.stocks s on vd.id_stock = s.id_stock "
            + "LEFT JOIN stock_facturacion.articulos a on a.id_articulo = s.id_articulo "
            + "LEFT JOIN stock_facturacion.compras v on v.id_compra = vd.id_compra "
            + "LEFT JOIN stock_facturacion.proveedores c1 on c1.id_proveedor = v.id_proveedor "
            + "LEFT JOIN stock_facturacion.cajeros c on c.id_cajero = v.id_cajero "
            + "WHERE fecha_compra::date >= '"+fecha_inicio+"'::date AND fecha_compra <= '"+fecha_fin+"'::date AND estado_compra = 1"
            + " ORDER BY 2 asc";
    System.out.println(sql);
    datosSolicitados = dataSource.obtenerDato(sql);
    while (datosSolicitados.next()) {
        html += "<tr>";
        html += "<td>" + datosSolicitados.getString("nro_factura_compra") + "</td>";
        html += "<td>" + datosSolicitados.getString("fecha") + "</td>";
        html += "<td>" + datosSolicitados.getString("ci_ruc_proveedor") + "</td>";
        html += "<td>" + datosSolicitados.getString("razon_social_proveedor") + "</td>";
        html += "<td>" + datosSolicitados.getString("articulo_descripcion") + "</td>";
        html += "<td>" + datosSolicitados.getString("cantidad_compra") + "</td>";
        html += "<td>" + datosSolicitados.getString("costo") + "</td>";
        html += "<td>" + datosSolicitados.getString("sub_total") + "</td>";
        html += "<td>" + datosSolicitados.getString("iva_aplicado") + "</td>";
        html += "<td>" + datosSolicitados.getString("iva_gs") + "</td>";
        html += "<td>" + datosSolicitados.getString("subTotalIva") + "</td>";
        
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
                                + "<tr><th colspan='9'>REPORTE DE COMPRAS POR FECHA DESDE : "+fecha_inicio+" HASTA "+fecha_fin+"</th></tr>"
                                + "<tr>"
                                + "<th>NRO FACTURA</th>"
                                + "<th>FECHA</th>"
                                + "<th>RUC PROVEEDOR</th>"
                                + "<th>RAZON SOCIAL PROVEEDOR</th>"
                                + "<th>ARTICULO</th>"
                                + "<th>CANTIDAD</th>"
                                + "<th>COSTO</th>"
                                + "<th>SUB TOTAL C/ IVA</th>"
                                + "<th>IVA APLICADO</th>"
                                + "<th>IVA GS</th>"
                                + "<th>SUB TOTAL SIN IVA</th>"
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

