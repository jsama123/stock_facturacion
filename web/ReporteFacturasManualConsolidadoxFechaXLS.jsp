
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
    String nombre_archivo = "Informe_facturas_manual_consolidado";
    String fecha_inicio = request.getParameter("fecha_inicio");
    String fecha_fin = request.getParameter("fecha_fin");
    String condicion = request.getParameter("condicion");
    ResultSet datosSolicitados = null;
    String sql = "";
    String sql1 = "";
    String html = "";
    sql = "SELECT "
            + "v.nro_factura_venta as nro_factura, "
            + "max(fecha_venta) as fecha_venta, "
            + "max(ci_ruc_cliente) as ci_ruc_cliente, "
            + "max(razon_social_cliente) as razon_social_cliente, "
            + "sum(CASE WHEN es_desc_gs THEN cantidad_venta*(precio_unitario::int-descuento_gs_venta)  "
            + "ELSE cantidad_venta*(precio_unitario::int-(precio_unitario::int*descuento_venta/100)::int) END) as total, "
            + "COALESCE(max(g.iva10), 0) as iva10, "
            + "COALESCE(max(b.iva5), 0) as iva5, "
            + "COALESCE(max(b.iva5), 0)+COALESCE(max(g.iva10), 0) as totalIva, "
            + "sum(CASE WHEN es_desc_gs THEN cantidad_venta*(precio_unitario::int-descuento_gs_venta)  "
            + "ELSE cantidad_venta*(precio_unitario::int-(precio_unitario::int*descuento_venta/100)::int) END) -  "
            + "(COALESCE(max(b.iva5), 0)+COALESCE(max(g.iva10), 0)) as totalSinIva "
            + "FROM stock_facturacion.ventas_manual_detalles vd  "
            + "LEFT JOIN stock_facturacion.ventas_manual v on v.id_venta_manual = vd.id_venta_manual "
            + "LEFT JOIN stock_facturacion.clientes c1 on c1.id_cliente = v.id_cliente "
            + "LEFT JOIN ( "
            + "SELECT "
            + "nro_factura_venta, "
            + "CASE WHEN max(iva_aplicado)=10 THEN sum(CASE WHEN es_desc_gs THEN (cantidad_venta*(precio_unitario::int-descuento_gs_venta))*9.0909/100  "
            + "ELSE (cantidad_venta*(precio_unitario::int-(precio_unitario::int*descuento_venta/100)::int))*9.0909/100 END)::int ELSE 0 END as iva10  "
            + "FROM stock_facturacion.ventas_manual_detalles vd  "
            + "LEFT JOIN stock_facturacion.ventas_manual v on v.id_venta_manual = vd.id_venta_manual "
            + "WHERE fecha_venta::date >='"+fecha_inicio+"'::date AND fecha_venta::date<='"+fecha_fin+"'::date AND estado_venta = 1 "
            + "AND nro_factura_venta !='' AND iva_aplicado = 10 "
            + "GROUP BY nro_factura_venta ) g on g.nro_factura_venta = v.nro_factura_venta "
            + "LEFT JOIN ( "
            + "SELECT "
            + "nro_factura_venta, "
            + "CASE WHEN min(iva_aplicado)=5 THEN sum(CASE WHEN es_desc_gs THEN (cantidad_venta*(precio_unitario::int-descuento_gs_venta))*0.047619 "
            + "ELSE (cantidad_venta*(precio_unitario::int-(precio_unitario::int*descuento_venta/100)::int))*0.047619 END)::int ELSE 0 END as iva5 "
            + "FROM stock_facturacion.ventas_manual_detalles vd  "
            + "LEFT JOIN stock_facturacion.ventas_manual v on v.id_venta_manual = vd.id_venta_manual "
            + "WHERE fecha_venta::date >='"+fecha_inicio+"'::date AND fecha_venta::date<='"+fecha_fin+"'::date AND estado_venta = 1 "
            + "AND nro_factura_venta !='' AND iva_aplicado = 5 "
            + "GROUP BY nro_factura_venta ) b on b.nro_factura_venta = v.nro_factura_venta "
            + "WHERE fecha_venta::date >='"+fecha_inicio+"'::date AND fecha_venta::date<='"+fecha_fin+"'::date AND estado_venta = 1 "
            + "AND v.nro_factura_venta !=''  "
            + "GROUP BY v.nro_factura_venta "
            + "ORDER BY 1 asc";
    datosSolicitados = dataSource.obtenerDato(sql);

    while (datosSolicitados.next()) {
        html += "<tr>";
        html += "<td>" + datosSolicitados.getString("nro_factura") + "</td>";
        html += "<td>" + datosSolicitados.getString("fecha_venta") + "</td>";
        html += "<td>" + datosSolicitados.getString("ci_ruc_cliente") + "</td>";
        html += "<td>" + datosSolicitados.getString("razon_social_cliente") + "</td>";
        html += "<td>" + datosSolicitados.getString("total") + "</td>";
        html += "<td>" + datosSolicitados.getString("iva10") + "</td>";
        html += "<td>" + datosSolicitados.getString("iva5") + "</td>";
        html += "<td>" + datosSolicitados.getString("totalIva") + "</td>";
        html += "<td>" + datosSolicitados.getString("totalSinIva") + "</td>";
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
                        + "<tr><th colspan='9'>REPORTE DE FACTURAS DE VENTAS MANUALES CONSOLIDADO DESDE : " + fecha_inicio + " HASTA " + fecha_fin + "</th></tr>"
                        + "<tr>"
                        + "<th>NRO FACTURA</th>"
                        + "<th>FECHA VENTA</th>"
                        + "<th>CI / RUC CLIENTE</th>"
                        + "<th>RAZON SOCIAL CLIENTE</th>"
                        + "<th>TOTAL VENTA</th>"
                        + "<th>IVA 10</th>"
                        + "<th>IVA 5</th>"
                        + "<th>TOTAL IVA</th>"
                        + "<th>TOTAL VENTA SIN IVA</th>"
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

