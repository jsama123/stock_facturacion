<%-- 
    Document   : GrupoDatos
    Created on : 5/06/2020, 10:08:25 PM
    Author     : Jose Samaniego
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="genericos.fuenteDatos"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="genericos.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Conexion cn = new Conexion();
    HttpSession sesion = (HttpSession) request.getSession();
    String usuario = (String) sesion.getAttribute("loginUsuario");
    ResultSet rs = null;
    ResultSet rs1 = null;
    StringBuilder htmlDatos = new StringBuilder();
    fuenteDatos dataSource = new fuenteDatos();
    dataSource.setConexion(cn.getConexion());

    DecimalFormat formatea = new DecimalFormat("###,###.##");

    String opcion = request.getParameter("opcion");
    String fecha = request.getParameter("fecha");
    String id = request.getParameter("id");
    String nombre_empresa = "";
    String sql = "";
    rs1 = dataSource.obtenerDato("SELECT nombre_empresa FROM usuarios WHERE login_usuario = '" + usuario + "'");
    if (rs1.next()) {
        nombre_empresa = rs1.getString("nombre_empresa");
    }
    switch (Integer.parseInt(opcion)) {
        case 1: //OBTIENE DATO INGRESOS TOTALES DE UN MES Y AÑO ESPECIFICO
            rs = dataSource.obtenerDato("SELECT "
                    + "sum(CASE WHEN es_desc_gs_venta THEN cantidad_venta*(precio_unitario::int-descuento_gs_venta) "
                    + "ELSE cantidad_venta*(precio_unitario::int-(precio_unitario::int*descuenta_venta/100)::int) END) as totalIngreso, "
                    + "to_char(fecha_venta::date, 'MM/YYYY') as fecha "
                    + "FROM stock_facturacion.ventas_detalles vd "
                    + "LEFT JOIN stock_facturacion.ventas v on v.id_venta = vd.id_venta "
                    + "WHERE to_char(fecha_venta::date, 'MM/YYYY') = '" + fecha + "' AND estado_venta = 1 "
                    + "GROUP BY fecha");
            if (rs.next()) {
                htmlDatos.append(formatea.format(Double.valueOf(rs.getString("totalIngreso"))));
            } else {
                htmlDatos.append("0");
            }
            break;
        case 2://OBTIENE DATOS DE ARTICULOS
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
                    + "WHERE to_char(fecha_compra::date, 'MM/YYYY') ='" + fecha + "' AND estado_compra = 1  "
                    + "AND iva_aplicado = 10  "
                    + "GROUP BY nro_factura_compra ) g on g.nro_factura_compra = v.nro_factura_compra  "
                    + "LEFT JOIN (  "
                    + "SELECT  "
                    + "nro_factura_compra,  "
                    + "CASE WHEN min(iva_aplicado)=5 THEN sum(cantidad_compra*(costo_unitario*0.047619))::int ELSE 0 END as iva5  "
                    + "FROM stock_facturacion.compras_detalles vd   "
                    + "LEFT JOIN stock_facturacion.compras v on v.id_compra = vd.id_compra  "
                    + "WHERE to_char(fecha_compra::date, 'MM/YYYY') ='" + fecha + "'  AND estado_compra = 1  "
                    + "AND iva_aplicado = 5  "
                    + "GROUP BY nro_factura_compra ) b on b.nro_factura_compra = v.nro_factura_compra  "
                    + "LEFT JOIN ( SELECT  "
                    + "nro_factura_compra,  "
                    + "sum(cantidad_compra*costo_unitario)::int as totaIva10  "
                    + "FROM stock_facturacion.compras_detalles vd   "
                    + "LEFT JOIN stock_facturacion.compras v on v.id_compra = vd.id_compra  "
                    + "WHERE to_char(fecha_compra::date, 'MM/YYYY') ='" + fecha + "'  AND estado_compra = 1  "
                    + "AND iva_aplicado = 10  "
                    + "GROUP BY nro_factura_compra ) h on h.nro_factura_compra = v.nro_factura_compra  "
                    + "LEFT JOIN (  "
                    + "SELECT  "
                    + "nro_factura_compra,  "
                    + "sum(cantidad_compra*costo_unitario)::int as totaIva5  "
                    + "FROM stock_facturacion.compras_detalles vd   "
                    + "LEFT JOIN stock_facturacion.compras v on v.id_compra = vd.id_compra  "
                    + "WHERE to_char(fecha_compra::date, 'MM/YYYY') ='" + fecha + "'  AND estado_compra = 1  "
                    + "AND iva_aplicado = 5  "
                    + "GROUP BY nro_factura_compra ) i on i.nro_factura_compra = v.nro_factura_compra  "
                    + "LEFT JOIN (  "
                    + "SELECT  "
                    + "nro_factura_compra,  "
                    + "sum(cantidad_compra*costo_unitario)::int as totaIva0  "
                    + "FROM stock_facturacion.compras_detalles vd   "
                    + "LEFT JOIN stock_facturacion.compras v on v.id_compra = vd.id_compra  "
                    + "WHERE to_char(fecha_compra::date, 'MM/YYYY') ='" + fecha + "'  AND estado_compra = 1  "
                    + "AND iva_aplicado = 0  "
                    + "GROUP BY nro_factura_compra ) k on k.nro_factura_compra = v.nro_factura_compra  "
                    + "WHERE to_char(fecha_compra::date, 'MM/YYYY') ='" + fecha + "' AND estado_compra = 1 "
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
                    + "WHERE to_char(fecha_gasto, 'MM/YYYY')='" + fecha + "'  "
                    + "AND iva_aplicado = 10  "
                    + "GROUP BY nro_comprobante_gasto ) g on g.nro_comprobante_gasto = vd.nro_comprobante_gasto  "
                    + "LEFT JOIN (  "
                    + "SELECT  "
                    + "nro_comprobante_gasto,  "
                    + "CASE WHEN min(iva_aplicado)=5 THEN sum(monto_gasto*0.047619)::int ELSE 0 END as iva5  "
                    + "FROM stock_facturacion.gastos vd  "
                    + "WHERE to_char(fecha_gasto, 'MM/YYYY')='" + fecha + "' "
                    + "AND iva_aplicado = 5  "
                    + "GROUP BY nro_comprobante_gasto ) b on b.nro_comprobante_gasto = vd.nro_comprobante_gasto  "
                    + "LEFT JOIN ( SELECT  "
                    + "nro_comprobante_gasto,  "
                    + "sum(monto_gasto)::int as totaIva10  "
                    + "FROM stock_facturacion.gastos vd  "
                    + "WHERE to_char(fecha_gasto, 'MM/YYYY')='" + fecha + "' "
                    + "AND iva_aplicado = 10 "
                    + "GROUP BY nro_comprobante_gasto ) h on h.nro_comprobante_gasto = vd.nro_comprobante_gasto  "
                    + "LEFT JOIN (  "
                    + "SELECT nro_comprobante_gasto,  "
                    + "sum(monto_gasto)::int as totaIva5  "
                    + "FROM stock_facturacion.gastos vd   "
                    + "WHERE to_char(fecha_gasto, 'MM/YYYY')='" + fecha + "' "
                    + "AND iva_aplicado = 5  "
                    + "GROUP BY nro_comprobante_gasto ) i on i.nro_comprobante_gasto = vd.nro_comprobante_gasto  "
                    + "LEFT JOIN (  "
                    + "SELECT  "
                    + "nro_comprobante_gasto,  "
                    + "sum(monto_gasto)::int as totaIva0  "
                    + "FROM stock_facturacion.gastos vd "
                    + "WHERE to_char(fecha_gasto, 'MM/YYYY')='" + fecha + "' "
                    + "AND iva_aplicado = 0 "
                    + "GROUP BY nro_comprobante_gasto ) k on k.nro_comprobante_gasto = vd.nro_comprobante_gasto  "
                    + "WHERE to_char(fecha_gasto::date, 'MM/YYYY')='" + fecha + "' "
                    + "GROUP BY vd.nro_comprobante_gasto  "
                    + "ORDER BY 5 asc) as x "
                    + "GROUP BY x.nro_factura ";
            //System.out.println(sql.toString());
            rs = dataSource.obtenerDato(sql);
            int count = 0;
            int totalIva10 = 0;
            int totalIva5 = 0;
            int totalIvaT = 0;
            String totalEgre = "";
            while (rs.next()) {
                totalIva10 += Integer.parseInt(rs.getString("totalIva10"));
                totalIva5 += Integer.parseInt(rs.getString("totalIva5"));
                totalIvaT = totalIva10 + totalIva5;
                totalEgre = String.valueOf(totalIvaT);
            }
            htmlDatos.append(formatea.format(Double.valueOf(totalEgre)));
            break;
        /*case 3:
         rs = dataSource.obtenerDato("SELECT "
         + "'Cod :'||id_compra||' |Nro Factura:'||nro_factura_compra||' |Fecha Compra:'||to_char(fecha_compra, 'DD/MM/YYYY')|| "
         + "' |Proveedor: '||ci_ruc_proveedor||'-'||razon_social_proveedor as datos "
         + "FROM stock_facturacion.compras c "
         + "LEFT JOIN stock_facturacion.proveedores p on p.id_proveedor = c.id_proveedor "
         + "WHERE estado_compra = 1");
         while(rs.next()){
         htmlDatos.append("<option value='" + rs.getString("datos") + "'>"
         + rs.getString("datos")
         + "</option>");
         }
         break;
         case 4:
         rs = dataSource.obtenerDato("SELECT "
         + "'Cod :'||id_ajuste_stock||' |Articulo:'||articulo_descripcion||' |Existencia:'||c.existencia::int|| "
         + "' |Cantidad: '||c.cantidad||' |Operacion:'||CASE WHEN c.operacion = 'S' THEN 'SUMA' ELSE 'RESTA' END as datos "
         + "FROM stock_facturacion.ajustes_stock c "
         + "LEFT JOIN stock_facturacion.stocks p on p.id_stock = c.id_stock "
         + "LEFT JOIN stock_facturacion.articulos a on a.id_articulo = p.id_articulo "
         + "WHERE estado = 1");
         while(rs.next()){
         htmlDatos.append("<option value='" + rs.getString("datos") + "'>"
         + rs.getString("datos")
         + "</option>");
         }
         break;
         case 5:
         rs = dataSource.obtenerDato("SELECT "
         + "'Cod :'||id_venta_manual||' |Nro Factura:'||nro_factura_venta||' |Fecha Venta:'||to_char(fecha_compra, 'DD/MM/YYYY')|| "
         + "' |Cliente '||ci_ruc_cliente||'-'||razon_social_cliente as datos "
         + "FROM stock_facturacion.ventas_manual c "
         + "LEFT JOIN stock_facturacion.clientes p on p.id_cliente = c.id_cliente "
         + "WHERE estado_venta = 1");
         while(rs.next()){
         htmlDatos.append("<option value='" + rs.getString("datos") + "'>"
         + rs.getString("datos")
         + "</option>");
         }
         break;
         case 6:
         rs = dataSource.obtenerDato("SELECT "
         + "'Cod :'||id_traspaso||' |Deposito Origen:'||p1.deposito_sucursal_descripcion||' |Deposito Destino:'||p.deposito_sucursal_descripcion|| "
         + "' |Fecha: '||c.fecha as datos "
         + "FROM stock_facturacion.traspasos c "
         + "LEFT JOIN stock_facturacion.depositos_sucursales p on p.id_deposito_sucursal = c.id_deposito_destino "
         + "LEFT JOIN stock_facturacion.depositos_sucursales p1 on p1.id_deposito_sucursal = c.id_deposito_origen "
         + "WHERE estado = 1");
         while(rs.next()){
         htmlDatos.append("<option value='" + rs.getString("datos") + "'>"
         + rs.getString("datos")
         + "</option>");
         }
         break;
         case 7:
         rs = dataSource.obtenerDato("SELECT "
         + "id_traspaso_detalle, "
         + "articulo_descripcion, "
         + "cantidad "
         + "FROM stock_facturacion.traspasos_detalles v "
         + "LEFT JOIN stock_facturacion.stocks s on s.id_stock = v.id_stock "
         + "LEFT JOIN stock_facturacion.articulos a on a.id_articulo = s.id_articulo "
         + "WHERE v.id_traspaso = " + id);
         while (rs.next()) {
         htmlDatos.append("<tr>"
         + "<td>" + rs.getString("articulo_descripcion") + "</td>"
         + "<td>" + rs.getString("cantidad") + "</td>"
         + "</tr>");
         }
         break;*/
    }
    out.print(htmlDatos.toString());
    cn.desConectarBD();
%>
