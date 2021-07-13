
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
    String añoMes = año+mes;
    
    ResultSet datosSolicitados = null;
    ResultSet datosSolicitados1 = null;
    ResultSet datosSolicitados2 = null;
    ResultSet datosSolicitados3 = null;
    ResultSet datosSolicitados4 = null;
    String sql = "";
    String sqlCantRegistros = "";
    String sqlCantRegistros2 = "";
    String sqlTotalFacturas = "";
    String sqlTotalFacturas2 = "";
    String cantReg = "";
    String cantReg2 = "";
    String totalFac = "";
    String totalFac2 = "";
    String html = "";
    sql = "SELECT max(x.ci_ruc_proveedor) as ci_ruc_proveedor, max(dv_proveedor) as dv_proveedor, max(razon_social_proveedor) as razon_social_proveedor, nro_factura "
            + ", max(fecha_compra) as fecha_compra, sum(totalIva10) as totalIva10, sum(iva10) as iva10, sum(totalIva5) as totaliva5, "
            + "sum(iva5) as iva5, sum(totalExenta) as totalExenta, sum(total) as total, max(tipo_compra) as tipo_compra, "
            + "max(cant_cuotas) as cant_cuotas, max(timbrado_compra) as timbrado_compra FROM (SELECT  "
            + "split_part(max(ci_ruc_proveedor), '-', 1) as ci_ruc_proveedor,  "
            + "split_part(max(ci_ruc_proveedor), '-', 2) as dv_proveedor,  "
            + "max(razon_social_proveedor) as razon_social_proveedor,  "
            + "v.nro_factura_compra as nro_factura,  "
            + "to_char(max(fecha_compra)::date, 'DD/MM/YYYY') as fecha_compra,  "
            + "COALESCE(max(h.totaIva10), 0) - COALESCE(max(g.iva10), 0) as totalIva10,  "
            + "COALESCE(max(g.iva10), 0) as iva10,   "
            + "COALESCE(max(i.totaIva5), 0)- COALESCE(max(b.iva5), 0) as totalIva5,  "
            + "COALESCE(max(b.iva5), 0) as iva5,  "
            + "COALESCE(max(k.totaIva0), 0) as totalExenta,  "
            + "sum(cantidad_compra*costo_unitario)::int as total, "
            + "CASE WHEN max(tipo_compra) = 'CON' THEN 1 ELSE 2 END as tipo_compra, "
            + "max(cantidad_cuota_compra) as cant_cuotas, "
            + "COALESCE(max(timbrado_compra), '0') as timbrado_compra  "
            + "FROM stock_facturacion.compras_detalles vd   "
            + "LEFT JOIN stock_facturacion.compras v on v.id_compra = vd.id_compra  "
            + "LEFT JOIN stock_facturacion.proveedores c1 on c1.id_proveedor = v.id_proveedor  "
            + "LEFT JOIN ( SELECT nro_factura_compra,  "
            + "CASE WHEN max(iva_aplicado)=10 THEN sum(cantidad_compra*(costo_unitario*0.090909))::int ELSE 0 END as iva10   "
            + "FROM stock_facturacion.compras_detalles vd   "
            + "LEFT JOIN stock_facturacion.compras v on v.id_compra = vd.id_compra  "
            + "WHERE fecha_compra::date >='"+fecha_inicio+"'::date AND fecha_compra::date<='"+fecha_fin+"'::date AND estado_compra = 1  "
            + "AND iva_aplicado = 10  "
            + "GROUP BY nro_factura_compra ) g on g.nro_factura_compra = v.nro_factura_compra  "
            + "LEFT JOIN (  "
            + "SELECT  "
            + "nro_factura_compra,  "
            + "CASE WHEN min(iva_aplicado)=5 THEN sum(cantidad_compra*(costo_unitario*0.047619))::int ELSE 0 END as iva5  "
            + "FROM stock_facturacion.compras_detalles vd   "
            + "LEFT JOIN stock_facturacion.compras v on v.id_compra = vd.id_compra  "
            + "WHERE fecha_compra::date >='"+fecha_inicio+"'::date AND fecha_compra::date<='"+fecha_fin+"'::date AND estado_compra = 1  "
            + "AND iva_aplicado = 5  "
            + "GROUP BY nro_factura_compra ) b on b.nro_factura_compra = v.nro_factura_compra  "
            + "LEFT JOIN ( SELECT  "
            + "nro_factura_compra,  "
            + "sum(cantidad_compra*costo_unitario)::int as totaIva10  "
            + "FROM stock_facturacion.compras_detalles vd   "
            + "LEFT JOIN stock_facturacion.compras v on v.id_compra = vd.id_compra  "
            + "WHERE fecha_compra::date >='"+fecha_inicio+"'::date AND fecha_compra::date<='"+fecha_fin+"'::date AND estado_compra = 1  "
            + "AND iva_aplicado = 10  "
            + "GROUP BY nro_factura_compra ) h on h.nro_factura_compra = v.nro_factura_compra  "
            + "LEFT JOIN (  "
            + "SELECT  "
            + "nro_factura_compra,  "
            + "sum(cantidad_compra*costo_unitario)::int as totaIva5  "
            + "FROM stock_facturacion.compras_detalles vd   "
            + "LEFT JOIN stock_facturacion.compras v on v.id_compra = vd.id_compra  "
            + "WHERE fecha_compra::date >='"+fecha_inicio+"'::date AND fecha_compra::date<='"+fecha_fin+"'::date AND estado_compra = 1  "
            + "AND iva_aplicado = 5  "
            + "GROUP BY nro_factura_compra ) i on i.nro_factura_compra = v.nro_factura_compra  "
            + "LEFT JOIN (  "
            + "SELECT  "
            + "nro_factura_compra,  "
            + "sum(cantidad_compra*costo_unitario)::int as totaIva0  "
            + "FROM stock_facturacion.compras_detalles vd   "
            + "LEFT JOIN stock_facturacion.compras v on v.id_compra = vd.id_compra  "
            + "WHERE fecha_compra::date >='"+fecha_inicio+"'::date AND fecha_compra::date<='"+fecha_fin+"'::date AND estado_compra = 1  "
            + "AND iva_aplicado = 0  "
            + "GROUP BY nro_factura_compra ) k on k.nro_factura_compra = v.nro_factura_compra  "
            + "WHERE fecha_compra::date >='"+fecha_inicio+"'::date AND fecha_compra::date<='"+fecha_fin+"'::date AND estado_compra = 1 "
            + "GROUP BY v.nro_factura_compra  "
            + "UNION "
            + "SELECT  "
            + "split_part(max(ci_ruc_proveedor), '-', 1) as ci_ruc_proveedor, "
            + "split_part(max(ci_ruc_proveedor), '-', 2) as dv_proveedor, "
            + "max(razon_social_proveedor) as razon_social_proveedor, "
            + "vd.nro_comprobante_gasto as nro_factura, "
            + "to_char(max(fecha_gasto)::date, 'DD/MM/YYYY') as fecha_gasto, "
            + "COALESCE(max(h.totaIva10), 0) - COALESCE(max(g.iva10), 0) as totalIva10, "
            + "COALESCE(max(g.iva10), 0) as iva10,  "
            + "COALESCE(max(i.totaIva5), 0)- COALESCE(max(b.iva5), 0) as totalIva5, "
            + "COALESCE(max(b.iva5), 0) as iva5, "
            + "COALESCE(max(k.totaIva0), 0) as totalExenta, "
            + "sum(monto_gasto)::int as total, "
            + "CASE WHEN max(tipo_gasto) = 'CON' THEN 1 ELSE 2 END as tipo_compra, "
            + "max(cantidad_cuota_gasto) as cant_cuotas, "
            + "COALESCE(max(timbrado_gasto), '0') as timbrado_gasto  "
            + "FROM stock_facturacion.gastos vd "
            + "LEFT JOIN stock_facturacion.proveedores c1 on c1.id_proveedor = vd.id_proveedor "
            + "LEFT JOIN ( SELECT nro_comprobante_gasto,  "
            + "CASE WHEN max(iva_aplicado)=10 THEN sum(monto_gasto*0.090909)::int ELSE 0 END as iva10   "
            + "FROM stock_facturacion.gastos vd   "
            + "WHERE fecha_gasto::date >='"+fecha_inicio+"'::date AND fecha_gasto::date<='"+fecha_fin+"'::date "
            + "AND iva_aplicado = 10  "
            + "GROUP BY nro_comprobante_gasto ) g on g.nro_comprobante_gasto = vd.nro_comprobante_gasto  "
            + "LEFT JOIN (  "
            + "SELECT  "
            + "nro_comprobante_gasto,  "
            + "CASE WHEN min(iva_aplicado)=5 THEN sum(monto_gasto*0.047619)::int ELSE 0 END as iva5  "
            + "FROM stock_facturacion.gastos vd  "
            + "WHERE fecha_gasto::date >='"+fecha_inicio+"'::date AND fecha_gasto::date<='"+fecha_fin+"'::date "
            + "AND iva_aplicado = 5  "
            + "GROUP BY nro_comprobante_gasto ) b on b.nro_comprobante_gasto = vd.nro_comprobante_gasto  "
            + "LEFT JOIN ( SELECT  "
            + "nro_comprobante_gasto,  "
            + "sum(monto_gasto)::int as totaIva10  "
            + "FROM stock_facturacion.gastos vd  "
            + "WHERE fecha_gasto::date >='"+fecha_inicio+"'::date AND fecha_gasto::date<='"+fecha_fin+"'::date "
            + "AND iva_aplicado = 10 "
            + "GROUP BY nro_comprobante_gasto ) h on h.nro_comprobante_gasto = vd.nro_comprobante_gasto  "
            + "LEFT JOIN (  "
            + "SELECT nro_comprobante_gasto,  "
            + "sum(monto_gasto)::int as totaIva5  "
            + "FROM stock_facturacion.gastos vd   "
            + "WHERE fecha_gasto::date >='"+fecha_inicio+"'::date AND fecha_gasto::date<='"+fecha_fin+"'::date "
            + "AND iva_aplicado = 5  "
            + "GROUP BY nro_comprobante_gasto ) i on i.nro_comprobante_gasto = vd.nro_comprobante_gasto  "
            + "LEFT JOIN (  "
            + "SELECT  "
            + "nro_comprobante_gasto,  "
            + "sum(monto_gasto)::int as totaIva0  "
            + "FROM stock_facturacion.gastos vd "
            + "WHERE fecha_gasto::date >='"+fecha_inicio+"'::date AND fecha_gasto::date<='"+fecha_fin+"'::date "
            + "AND iva_aplicado = 0 "
            + "GROUP BY nro_comprobante_gasto ) k on k.nro_comprobante_gasto = vd.nro_comprobante_gasto  "
            + "WHERE fecha_gasto::date >='"+fecha_inicio+"'::date AND fecha_gasto::date<='"+fecha_fin+"'::date "
            + "GROUP BY vd.nro_comprobante_gasto  "
            + "ORDER BY 5 asc) as x "
            + "GROUP BY x.nro_factura ";
    datosSolicitados = dataSource.obtenerDato(sql);
    int count = 0;
    int totalIva10 = 0;
    int totalIva5 = 0;
    int totalIvaT = 0;
    while (datosSolicitados.next()) {
        html += "<tr>";
        html += "<td>2</td>";
        html += "<td>" + datosSolicitados.getString("ci_ruc_proveedor") + "</td>";
        html += "<td>" + datosSolicitados.getString("dv_proveedor") + "</td>";
        html += "<td>" + datosSolicitados.getString("razon_social_proveedor") + "</td>";
        html += "<td>" + datosSolicitados.getString("timbrado_compra") + "</td>";
        html += "<td>1</td>";
        html += "<td>" + datosSolicitados.getString("nro_factura") + "</td>";
        html += "<td>" + datosSolicitados.getString("fecha_compra") + "</td>";
        html += "<td>" + datosSolicitados.getString("totalIva10") + "</td>";
        html += "<td>" + datosSolicitados.getString("iva10") + "</td>";
        html += "<td>" + datosSolicitados.getString("totalIva5") + "</td>";
        html += "<td>" + datosSolicitados.getString("iva5") + "</td>";
        html += "<td>" + datosSolicitados.getString("totalExenta") + "</td>";
        html += "<td>0</td>";
        html += "<td>" + datosSolicitados.getString("tipo_compra") + "</td>";
        html += "<td>" + datosSolicitados.getString("cant_cuotas") + "</td>";
        html += "</tr>";
        ++count;
        totalIva10 += Integer.parseInt(datosSolicitados.getString("totalIva10"));
        totalIva5  += Integer.parseInt(datosSolicitados.getString("totalIva5"));
        totalIvaT = totalIva10+totalIva5;
    }
    
    sqlCantRegistros = "SELECT "
            + "count(id_compra) as cantidad "
            + "FROM stock_facturacion.compras "
            + "WHERE fecha_compra::date >='"+fecha_inicio+"'::date AND fecha_compra::date<='"+fecha_fin+"'::date AND estado_compra = 1 ";
    sqlCantRegistros2 = "SELECT "
            + "count(id_gasto) as cantidad "
            + "FROM stock_facturacion.gastos "
            + "WHERE fecha_gasto::date >='"+fecha_inicio+"'::date AND fecha_gasto::date<='"+fecha_fin+"'::date";
    datosSolicitados1 = dataSource.obtenerDato(sqlCantRegistros);
    datosSolicitados3 = dataSource.obtenerDato(sqlCantRegistros2);
    if(datosSolicitados1.next()){
        cantReg =datosSolicitados1.getString("cantidad");
    }
    if(datosSolicitados3.next()){
        cantReg2 = datosSolicitados3.getString("cantidad");
    }
    
    sqlTotalFacturas = "SELECT "
            + "sum(cantidad_compra*costo_unitario)::int as total "
            + "FROM stock_facturacion.compras_detalles vd  "
            + "LEFT JOIN stock_facturacion.compras v on v.id_compra = vd.id_compra "
            + "WHERE fecha_compra::date >='"+fecha_inicio+"'::date AND fecha_compra::date<='"+fecha_fin+"'::date AND estado_compra = 1 ";
    sqlTotalFacturas2 = "SELECT "
            + "sum(monto_gasto)::int as total "
            + "FROM stock_facturacion.gastos vd  "
            + "WHERE fecha_gasto::date >='"+fecha_inicio+"'::date AND fecha_gasto::date<='"+fecha_fin+"'::date";
    datosSolicitados2 = dataSource.obtenerDato(sqlTotalFacturas);
    datosSolicitados4 = dataSource.obtenerDato(sqlTotalFacturas2);
    if(datosSolicitados2.next()){
        totalFac = datosSolicitados2.getString("total");
    }
    if(datosSolicitados4.next()){
        totalFac2 = datosSolicitados4.getString("total");
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
            int cantRegInt = 0;
            cantRegInt = Integer.parseInt(cantReg);
            int cantRegInt2 = 0;
            cantRegInt2 = Integer.parseInt(cantReg2);
            int cantTotal = cantRegInt+cantRegInt2;
            int totalFacInt = 0;
            totalFacInt = Integer.parseInt(totalFac);
            int totalFacInt2 = 0;
            totalFacInt2 = Integer.parseInt(totalFac2);
            int totalFac3 = totalFacInt+totalFacInt2;
                out.print("<thead>"
                        //+ "<tr><th colspan='10'>REPORTE DE FACTURAS DE VENTAS CONSOLIDADO DESDE : " + fecha_inicio + " HASTA " + fecha_fin + "</th></tr>"
                        + "<tr>"
                        + "<th>1</th>"
                        + "<th>"+añoMes+"</th>"
                        + "<th>1</th>"
                        + "<th>911</th>"
                        + "<th>211</th>"
                        + "<th>4524748</th>"
                        + "<th>0</th>"
                        + "<th>JOSE CARLOS CACERES ENCISO</th>"
                        + "<th></th>"
                        + "<th>0</th>"
                        + "<th></th>"
                        + "<th>"+count+"</th>"
                        + "<th>"+totalIvaT+"</th>"
                        +"<th>NO</th>"
                        + "<th>2</th>"
                        + "<th></th>"
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

