
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
    String nombre_archivo = "Reporte_Ventas_Manuales_x_Fecha";
    String fecha_inicio = request.getParameter("fecha_inicio");
    String fecha_fin = request.getParameter("fecha_fin");
    ResultSet datosSolicitados = null;
    String sql = "";
    String html = "";
    sql = "SELECT "
            + "v.id_venta_manual, "
            + "nro_factura_venta as nro_factura_venta, "
            + "fecha_venta as fecha, "
            + "iva_aplicado as iva_aplicado, "
            + "ci_ruc_cliente as ci_ruc_cliente, "
            + "razon_social_cliente as razon_social_cliente, "
            + "vd.id_stock as id_stock, "
            + "cantidad_venta as cantidad_venta, "
            + "articulo_descripcion, "
            + "CASE WHEN es_desc_gs THEN descuento_gs_venta*cantidad_venta ELSE "
            + "cantidad_venta*precio_unitario::int*descuento_venta/100 END as desc_aplicado, "
            + "CASE WHEN es_desc_gs THEN precio_unitario::int-descuento_gs_venta "
            + "ELSE precio_unitario::int-(precio_unitario::int*descuento_venta/100)::int END as precio_unitario,  "
            + "CASE WHEN es_desc_gs THEN cantidad_venta*(precio_unitario::int-descuento_gs_venta) "
            + "ELSE cantidad_venta*(precio_unitario::int-(precio_unitario::int*descuento_venta/100)::int) END as sub_total, "
            + "CASE WHEN es_desc_gs THEN (cantidad_venta*(precio_unitario::int-descuento_gs_venta))*iva_aplicado/100 "
            + "ELSE (cantidad_venta*(precio_unitario::int-(precio_unitario::int*descuento_venta/100)::int))*iva_aplicado/100 END as iva_gs,"
            + "CASE WHEN es_desc_gs THEN (cantidad_venta*(precio_unitario::int-descuento_gs_venta))-((cantidad_venta*(precio_unitario::int-descuento_gs_venta))*iva_aplicado/100) "
            + "ELSE (cantidad_venta*(precio_unitario::int-(precio_unitario::int*descuento_venta/100)::int))-((cantidad_venta*(precio_unitario::int-(precio_unitario::int*descuento_venta/100)::int))*iva_aplicado/100) END as sub_tota_iva "
            + "FROM stock_facturacion.ventas_manual_detalles vd "
            + "LEFT JOIN stock_facturacion.stocks s on vd.id_stock = s.id_stock "
            + "LEFT JOIN stock_facturacion.articulos a on a.id_articulo = s.id_articulo "
            + "LEFT JOIN stock_facturacion.ventas_manual v on v.id_venta_manual = vd.id_venta_manual "
            + "LEFT JOIN stock_facturacion.clientes c1 on c1.id_cliente = v.id_cliente "
            + "WHERE fecha_venta::date >='"+fecha_inicio+"'::date AND fecha_venta::date<='"+fecha_fin+"'::date AND estado_venta = 1 "
            + "ORDER BY 2 asc";
    System.out.println(sql);
    datosSolicitados = dataSource.obtenerDato(sql);
    while (datosSolicitados.next()) {
        html += "<tr>";
        html += "<td>" + datosSolicitados.getString("nro_factura_venta") + "</td>";
        html += "<td>" + datosSolicitados.getString("fecha") + "</td>";
        html += "<td>" + datosSolicitados.getString("ci_ruc_cliente") + "</td>";
        html += "<td>" + datosSolicitados.getString("razon_social_cliente") + "</td>";
        html += "<td>" + datosSolicitados.getString("articulo_descripcion") + "</td>";
        html += "<td>" + datosSolicitados.getString("cantidad_venta") + "</td>";
        html += "<td>" + datosSolicitados.getString("desc_aplicado") + "</td>";
        html += "<td>" + datosSolicitados.getString("precio_unitario") + "</td>";
        html += "<td>" + datosSolicitados.getString("sub_total") + "</td>";
        html += "<td>" + datosSolicitados.getString("iva_aplicado") + "</td>";
        html += "<td>" + datosSolicitados.getString("iva_gs") + "</td>";
        html += "<td>" + datosSolicitados.getString("sub_tota_iva") + "</td>";
        
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
                                + "<tr><th colspan='10'>REPORTE DE VENTAS MANUALES POR FECHA DESDE : "+fecha_inicio+" HASTA "+fecha_fin+"</th></tr>"
                                + "<tr>"
                                + "<th>NRO COMPROBANTE</th>"
                                + "<th>FECHA</th>"
                                + "<th>RUC CLIENTE</th>"
                                + "<th>RAZON SOCIAL CLIENTE</th>"
                                + "<th>ARTICULO</th>"
                                + "<th>CANTIDAD</th>"
                                + "<th>DESC APLICADO</th>"
                                + "<th>PRECIO</th>"
                                + "<th>SUB TOTAL</th>"
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

