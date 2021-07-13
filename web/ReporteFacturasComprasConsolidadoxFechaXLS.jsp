
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
    String nombre_archivo = "Informe_facturas_compras_consolidado";
    String fecha_inicio = request.getParameter("fecha_inicio");
    String fecha_fin = request.getParameter("fecha_fin");
    String condicion = request.getParameter("condicion");
    ResultSet datosSolicitados = null;
    String sql = "";
    String sql1 = "";
    String html = "";
    sql = "SELECT "
            + "v.nro_factura_compra as nro_factura, "
            + "max(fecha_compra) as fecha_compra, "
            + "max(ci_ruc_proveedor) as ci_ruc_proveedor, "
            + "max(razon_social_proveedor) as razon_social_proveedor, "
            + "sum(cantidad_compra*costo_unitario::int) as total, "
            + "COALESCE(max(g.iva10), 0)::int as iva10, "
            + "COALESCE(max(b.iva5), 0)::int as iva5, "
            + "COALESCE(max(b.iva5), 0)::int+COALESCE(max(g.iva10), 0)::int as totalIva, "
            + "(sum(cantidad_compra*costo_unitario::int))::int -  "
            + "(COALESCE(max(b.iva5), 0)+COALESCE(max(g.iva10), 0))::int as totalSinIva "
            + "FROM stock_facturacion.compras_detalles vd  "
            + "LEFT JOIN stock_facturacion.compras v on v.id_compra = vd.id_compra "
            + "LEFT JOIN stock_facturacion.proveedores c1 on c1.id_proveedor = v.id_proveedor "
            + "LEFT JOIN ( SELECT "
            + "nro_factura_compra, "
            + "CASE WHEN max(iva_aplicado)=10 THEN sum(cantidad_compra*costo_unitario::int)*9.0909/100 ELSE 0 END as iva10  "
            + "FROM stock_facturacion.compras_detalles vd  "
            + "LEFT JOIN stock_facturacion.compras v on v.id_compra = vd.id_compra "
            + "WHERE fecha_compra::date >='"+fecha_inicio+"'::date AND fecha_compra::date<='"+fecha_fin+"'::date AND estado_compra = 1 "
            + "AND iva_aplicado = 10 "
            + "GROUP BY nro_factura_compra ) g on g.nro_factura_compra = v.nro_factura_compra "
            + "LEFT JOIN ( "
            + "SELECT "
            + "nro_factura_compra, "
            + "CASE WHEN min(iva_aplicado)=5 THEN sum(cantidad_compra*costo_unitario::int)*0.047619 ELSE 0 END as iva5 "
            + "FROM stock_facturacion.compras_detalles vd  "
            + "LEFT JOIN stock_facturacion.compras v on v.id_compra = vd.id_compra "
            + "WHERE fecha_compra::date >='"+fecha_inicio+"'::date AND fecha_compra::date<='"+fecha_fin+"'::date AND estado_compra = 1 "
            + "AND iva_aplicado = 5 "
            + "GROUP BY nro_factura_compra ) b on b.nro_factura_compra = v.nro_factura_compra "
            + "WHERE fecha_compra::date >='"+fecha_inicio+"'::date AND fecha_compra::date<='"+fecha_fin+"'::date AND estado_compra = 1 "
            + "GROUP BY v.nro_factura_compra "
            + "ORDER BY 2 asc";
    datosSolicitados = dataSource.obtenerDato(sql);

    while (datosSolicitados.next()) {
        html += "<tr>";
        html += "<td>" + datosSolicitados.getString("nro_factura") + "</td>";
        html += "<td>" + datosSolicitados.getString("fecha_compra") + "</td>";
        html += "<td>" + datosSolicitados.getString("ci_ruc_proveedor") + "</td>";
        html += "<td>" + datosSolicitados.getString("razon_social_proveedor") + "</td>";
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
                        + "<tr><th colspan='9'>REPORTE DE FACTURAS DE COMPRAS CONSOLIDADO DESDE : " + fecha_inicio + " HASTA " + fecha_fin + "</th></tr>"
                        + "<tr>"
                        + "<th>NRO FACTURA</th>"
                        + "<th>FECHA COMPRA</th>"
                        + "<th>CI / RUC PROVEEDOR</th>"
                        + "<th>RAZON SOCIAL PROVEEDOR</th>"
                        + "<th>TOTAL COMPRA</th>"
                        + "<th>IVA 10</th>"
                        + "<th>IVA 5</th>"
                        + "<th>TOTAL IVA</th>"
                        + "<th>TOTAL COMPRA SIN IVA</th>"
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

