
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
    String nombre_archivo = "Informe_facturas_consolidado";
    String fecha_inicio = request.getParameter("fecha_inicio");
    String fecha_fin = request.getParameter("fecha_fin");
    String condicion = request.getParameter("condicion");

    String[] partes = fecha_inicio.split("-");
    String año = partes[0];
    String mes = partes[1];
    String añoMes = año + mes;

    ResultSet datosSolicitados = null;
    ResultSet datosSolicitados1 = null;
    ResultSet datosSolicitados2 = null;
    String sql = "";
    String sqlCantRegistros = "";
    String sqlTotalFacturas = "";
    String cantReg = "";
    String totalFac = "";
    String html = "";
    sql = "SELECT "
            + "split_part(max(ci_ruc_cliente), '-', 1) as ci_ruc_cliente, "
            + "split_part(max(ci_ruc_cliente), '-', 2) as dv_cliente, "
            + "max(razon_social_cliente) as razon_social_cliente, "
            + "v.nro_factura_venta as nro_factura, "
            + "to_char(max(fecha_venta)::date, 'DD/MM/YYYY') as fecha_venta, "
            + "COALESCE(max(h.totaIva10), 0) - COALESCE(max(g.iva10), 0) as totalIva10, "
            + "COALESCE(max(g.iva10), 0) as iva10,  "
            + "COALESCE(max(i.totaIva5), 0)- COALESCE(max(b.iva5), 0) as totalIva5, "
            + "COALESCE(max(b.iva5), 0) as iva5, "
            + "COALESCE(max(k.totaIva0), 0) as totalExenta, "
            + "sum(CASE WHEN es_desc_gs_venta THEN cantidad_venta*(precio_unitario::int-descuento_gs_venta) "
            + "ELSE cantidad_venta*(precio_unitario::int-(precio_unitario::int*descuenta_venta/100)::int) END) as total,"
            + "max(t.numero_timbrado) as numero_timbrado "
            + "FROM stock_facturacion.ventas_detalles vd  "
            + "LEFT JOIN stock_facturacion.ventas v on v.id_venta = vd.id_venta "
            + "LEFT JOIN stock_facturacion.timbrados t on t.id_timbrado = v.id_timbrado::int "
            + "LEFT JOIN stock_facturacion.clientes c1 on c1.id_cliente = v.id_cliente "
            + "LEFT JOIN ( SELECT nro_factura_venta, "
            + "CASE WHEN max(iva_aplicado)=10 THEN sum(CASE WHEN es_desc_gs_venta THEN (cantidad_venta*(precio_unitario::int-descuento_gs_venta))*9.0909/100  "
            + "ELSE (cantidad_venta*(precio_unitario::int-(precio_unitario::int*descuenta_venta/100)::int))*9.0909/100 END)::int ELSE 0 END as iva10  "
            + "FROM stock_facturacion.ventas_detalles vd  "
            + "LEFT JOIN stock_facturacion.ventas v on v.id_venta = vd.id_venta "
            + "WHERE fecha_venta::date >='" + fecha_inicio + "'::date AND fecha_venta::date<='" + fecha_fin + "'::date AND estado_venta = 1 "
            + "AND id_timbrado !='' AND iva_aplicado = 10 "
            + "GROUP BY nro_factura_venta ) g on g.nro_factura_venta = v.nro_factura_venta "
            + "LEFT JOIN ( SELECT nro_factura_venta, "
            + "CASE WHEN min(iva_aplicado)=5 THEN sum(CASE WHEN es_desc_gs_venta THEN (cantidad_venta*(precio_unitario::int-descuento_gs_venta))*0.047619 "
            + "ELSE (cantidad_venta*(precio_unitario::int-(precio_unitario::int*descuenta_venta/100)::int))*0.047619 END)::int ELSE 0 END as iva5 "
            + "FROM stock_facturacion.ventas_detalles vd  "
            + "LEFT JOIN stock_facturacion.ventas v on v.id_venta = vd.id_venta "
            + "WHERE fecha_venta::date >='" + fecha_inicio + "'::date AND fecha_venta::date<='" + fecha_fin + "'::date AND estado_venta = 1 "
            + "AND id_timbrado !='' AND iva_aplicado = 5 "
            + "GROUP BY nro_factura_venta ) b on b.nro_factura_venta = v.nro_factura_venta "
            + "LEFT JOIN ( SELECT nro_factura_venta, sum(CASE WHEN es_desc_gs_venta THEN cantidad_venta*(precio_unitario::int-descuento_gs_venta)  "
            + "ELSE cantidad_venta*(precio_unitario::int-(precio_unitario::int*descuenta_venta/100)::int) END) as totaIva10 "
            + "FROM stock_facturacion.ventas_detalles vd  "
            + "LEFT JOIN stock_facturacion.ventas v on v.id_venta = vd.id_venta "
            + "WHERE fecha_venta::date >='" + fecha_inicio + "'::date AND fecha_venta::date<='" + fecha_fin + "'::date AND estado_venta = 1 "
            + "AND id_timbrado !='' AND iva_aplicado = 10 "
            + "GROUP BY nro_factura_venta ) h on h.nro_factura_venta = v.nro_factura_venta "
            + "LEFT JOIN ( SELECT nro_factura_venta, sum(CASE WHEN es_desc_gs_venta THEN cantidad_venta*(precio_unitario::int-descuento_gs_venta)  "
            + "ELSE cantidad_venta*(precio_unitario::int-(precio_unitario::int*descuenta_venta/100)::int) END) as totaIva5 "
            + "FROM stock_facturacion.ventas_detalles vd  "
            + "LEFT JOIN stock_facturacion.ventas v on v.id_venta = vd.id_venta "
            + "WHERE fecha_venta::date >='" + fecha_inicio + "'::date AND fecha_venta::date<='" + fecha_fin + "'::date AND estado_venta = 1 "
            + "AND id_timbrado !='' AND iva_aplicado = 5 "
            + "GROUP BY nro_factura_venta ) i on i.nro_factura_venta = v.nro_factura_venta "
            + "LEFT JOIN ( SELECT nro_factura_venta, sum(CASE WHEN es_desc_gs_venta THEN cantidad_venta*(precio_unitario::int-descuento_gs_venta)  "
            + "ELSE cantidad_venta*(precio_unitario::int-(precio_unitario::int*descuenta_venta/100)::int) END) as totaIva0 "
            + "FROM stock_facturacion.ventas_detalles vd  "
            + "LEFT JOIN stock_facturacion.ventas v on v.id_venta = vd.id_venta "
            + "WHERE fecha_venta::date >='" + fecha_inicio + "'::date AND fecha_venta::date<='" + fecha_fin + "'::date AND estado_venta = 1 "
            + "AND id_timbrado !='' AND iva_aplicado = 0 "
            + "GROUP BY nro_factura_venta ) k on k.nro_factura_venta = v.nro_factura_venta "
            + "WHERE fecha_venta::date >='" + fecha_inicio + "'::date AND fecha_venta::date<='" + fecha_fin + "'::date AND estado_venta = 1 "
            + "AND v.id_timbrado !='' AND ci_ruc_cliente != '44444401-7' "
            + "GROUP BY v.nro_factura_venta "
            + "UNION "
            + "SELECT "
            + "split_part(max(ci_ruc_cliente), '-', 1) as ci_ruc_cliente, "
            + "split_part(max(ci_ruc_cliente), '-', 2) as dv_cliente, "
            + "max('IMPORTES CONSOLIDADOS') as razon_social_cliente, "
            + "max('0') as nro_factura, "
            + "to_char(max(fecha_venta)::date, 'DD/MM/YYYY') as fecha_venta, "
            + "COALESCE(max(h.totaIva10), 0) - COALESCE(max(g.iva10), 0) as totalIva10, "
            + "COALESCE(max(g.iva10), 0) as iva10,  "
            + "COALESCE(max(i.totaIva5), 0)- COALESCE(max(b.iva5), 0) as totalIva5, "
            + "COALESCE(max(b.iva5), 0) as iva5, "
            + "COALESCE(max(k.totaIva0), 0) as totalExenta, "
            + "sum(CASE WHEN es_desc_gs_venta THEN cantidad_venta*(precio_unitario::int-descuento_gs_venta) "
            + "ELSE cantidad_venta*(precio_unitario::int-(precio_unitario::int*descuenta_venta/100)::int) END) as total, "
            + "max(0) as numero_timbrado "
            + "FROM stock_facturacion.ventas_detalles vd  "
            + "LEFT JOIN stock_facturacion.ventas v on v.id_venta = vd.id_venta "
            + "LEFT JOIN stock_facturacion.timbrados t on t.id_timbrado = v.id_timbrado::int "
            + "LEFT JOIN stock_facturacion.clientes c1 on c1.id_cliente = v.id_cliente "
            + "LEFT JOIN ( SELECT id_cliente, CASE WHEN max(iva_aplicado)=10 THEN sum(CASE WHEN es_desc_gs_venta THEN (cantidad_venta*(precio_unitario::int-descuento_gs_venta))*9.0909/100  "
            + "ELSE (cantidad_venta*(precio_unitario::int-(precio_unitario::int*descuenta_venta/100)::int))*9.0909/100 END)::int ELSE 0 END as iva10  "
            + "FROM stock_facturacion.ventas_detalles vd  "
            + "LEFT JOIN stock_facturacion.ventas v on v.id_venta = vd.id_venta "
            + "WHERE fecha_venta::date >='" + fecha_inicio + "'::date AND fecha_venta::date<='" + fecha_fin + "'::date AND estado_venta = 1 "
            + "AND id_timbrado !='' AND iva_aplicado = 10 "
            + "GROUP BY id_cliente ) g on g.id_cliente = v.id_cliente "
            + "LEFT JOIN ( SELECT id_cliente, CASE WHEN min(iva_aplicado)=5 THEN sum(CASE WHEN es_desc_gs_venta THEN (cantidad_venta*(precio_unitario::int-descuento_gs_venta))*0.047619 "
            + "ELSE (cantidad_venta*(precio_unitario::int-(precio_unitario::int*descuenta_venta/100)::int))*0.047619 END)::int ELSE 0 END as iva5 "
            + "FROM stock_facturacion.ventas_detalles vd  "
            + "LEFT JOIN stock_facturacion.ventas v on v.id_venta = vd.id_venta "
            + "WHERE fecha_venta::date >='" + fecha_inicio + "'::date AND fecha_venta::date<='" + fecha_fin + "'::date AND estado_venta = 1 "
            + "AND id_timbrado !='' AND iva_aplicado = 5 "
            + "GROUP BY id_cliente ) b on b.id_cliente = v.id_cliente "
            + "LEFT JOIN ( SELECT id_cliente, sum(CASE WHEN es_desc_gs_venta THEN cantidad_venta*(precio_unitario::int-descuento_gs_venta)  "
            + "ELSE cantidad_venta*(precio_unitario::int-(precio_unitario::int*descuenta_venta/100)::int) END) as totaIva10 "
            + "FROM stock_facturacion.ventas_detalles vd  "
            + "LEFT JOIN stock_facturacion.ventas v on v.id_venta = vd.id_venta "
            + "WHERE fecha_venta::date >='" + fecha_inicio + "'::date AND fecha_venta::date<='" + fecha_fin + "'::date AND estado_venta = 1 "
            + "AND id_timbrado !='' AND iva_aplicado = 10 "
            + "GROUP BY id_cliente ) h on h.id_cliente = v.id_cliente "
            + "LEFT JOIN ( SELECT id_cliente, sum(CASE WHEN es_desc_gs_venta THEN cantidad_venta*(precio_unitario::int-descuento_gs_venta)  "
            + "ELSE cantidad_venta*(precio_unitario::int-(precio_unitario::int*descuenta_venta/100)::int) END) as totaIva5 "
            + "FROM stock_facturacion.ventas_detalles vd  "
            + "LEFT JOIN stock_facturacion.ventas v on v.id_venta = vd.id_venta "
            + "WHERE fecha_venta::date >='" + fecha_inicio + "'::date AND fecha_venta::date<='" + fecha_fin + "'::date AND estado_venta = 1 "
            + "AND id_timbrado !='' AND iva_aplicado = 5 "
            + "GROUP BY id_cliente ) i on i.id_cliente = v.id_cliente "
            + "LEFT JOIN ( SELECT id_cliente, sum(CASE WHEN es_desc_gs_venta THEN cantidad_venta*(precio_unitario::int-descuento_gs_venta)  "
            + "ELSE cantidad_venta*(precio_unitario::int-(precio_unitario::int*descuenta_venta/100)::int) END) as totaIva0 "
            + "FROM stock_facturacion.ventas_detalles vd  "
            + "LEFT JOIN stock_facturacion.ventas v on v.id_venta = vd.id_venta "
            + "WHERE fecha_venta::date >='" + fecha_inicio + "'::date AND fecha_venta::date<='" + fecha_fin + "'::date AND estado_venta = 1 "
            + "AND id_timbrado !='' AND iva_aplicado = 0 "
            + "GROUP BY id_cliente ) k on k.id_cliente = v.id_cliente "
            + "WHERE fecha_venta::date >='" + fecha_inicio + "'::date AND fecha_venta::date<='" + fecha_fin + "'::date AND estado_venta = 1 "
            + "AND v.id_timbrado !='' AND ci_ruc_cliente = '44444401-7'"
            + "GROUP BY v.id_cliente "
            + "ORDER BY 4 asc";
    datosSolicitados = dataSource.obtenerDato(sql);
    int count = 0;
    while (datosSolicitados.next()) {
        html += "<tr>";
        html += "<td>2</td>";
        html += "<td>" + datosSolicitados.getString("ci_ruc_cliente") + "</td>";
        html += "<td>" + datosSolicitados.getString("dv_cliente") + "</td>";
        html += "<td>" + datosSolicitados.getString("razon_social_cliente") + "</td>";
        if (datosSolicitados.getString("ci_ruc_cliente").equals("44444401")) {
            html += "<td>0</td>";
        } else {
            html += "<td>1</td>";
        }
        html += "<td>" + datosSolicitados.getString("nro_factura") + "</td>";
        html += "<td>" + datosSolicitados.getString("fecha_venta") + "</td>";
        html += "<td>" + datosSolicitados.getString("totalIva10") + "</td>";
        html += "<td>" + datosSolicitados.getString("iva10") + "</td>";
        html += "<td>" + datosSolicitados.getString("totalIva5") + "</td>";
        html += "<td>" + datosSolicitados.getString("iva5") + "</td>";
        html += "<td>" + datosSolicitados.getString("totalExenta") + "</td>";
        html += "<td>" + datosSolicitados.getString("total") + "</td>";
        html += "<td>1</td>";
        html += "<td>0</td>";
        html += "<td>" + datosSolicitados.getString("numero_timbrado") + "</td>";
        html += "</tr>";
        ++count;
    }

    sqlCantRegistros = "SELECT "
            + "count(id_venta) as cantidad "
            + "FROM stock_facturacion.ventas "
            + "WHERE fecha_venta::date >='" + fecha_inicio + "'::date AND fecha_venta::date<='" + fecha_fin + "'::date AND estado_venta = 1 "
            + "AND id_timbrado !='' ";
    datosSolicitados1 = dataSource.obtenerDato(sqlCantRegistros);
    if (datosSolicitados1.next()) {
        cantReg = datosSolicitados1.getString("cantidad");
    }

    sqlTotalFacturas = "SELECT "
            + "sum(CASE WHEN es_desc_gs_venta THEN cantidad_venta*(precio_unitario::int-descuento_gs_venta)  "
            + "ELSE cantidad_venta*(precio_unitario::int-(precio_unitario::int*descuenta_venta/100)::int) END) as total "
            + "FROM stock_facturacion.ventas_detalles vd  "
            + "LEFT JOIN stock_facturacion.ventas v on v.id_venta = vd.id_venta "
            + "WHERE fecha_venta::date >='" + fecha_inicio + "'::date AND fecha_venta::date<='" + fecha_fin + "'::date AND estado_venta = 1 "
            + "AND v.id_timbrado !='' ";
    datosSolicitados2 = dataSource.obtenerDato(sqlTotalFacturas);
    if (datosSolicitados2.next()) {
        totalFac = datosSolicitados2.getString("total");
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
                        //+ "<tr><th colspan='10'>REPORTE DE FACTURAS DE VENTAS CONSOLIDADO DESDE : " + fecha_inicio + " HASTA " + fecha_fin + "</th></tr>"
                        + "<tr>"
                        + "<th>1</th>"
                        + "<th>" + añoMes + "</th>"
                        + "<th>1</th>"
                        + "<th>921</th>"
                        + "<th>221</th>"
                        + "<th>4524748</th>"
                        + "<th>0</th>"
                        + "<th>JOSE CARLOS CACERES ENCISO</th>"
                        + "<th></th>"
                        + "<th>0</th>"
                        + "<th></th>"
                        + "<th>" + count + "</th>"
                        + "<th>" + totalFac + "</th>"
                        + "<th>2</th>"
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

