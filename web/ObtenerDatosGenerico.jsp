<%-- 
    Document   : GrupoDatos
    Created on : 5/06/2020, 10:08:25 PM
    Author     : Jose Samaniego
--%>

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

    String opcion = request.getParameter("opcion");
    String id = request.getParameter("id");
    String nombre_empresa = "";
    rs1 = dataSource.obtenerDato("SELECT nombre_empresa FROM usuarios WHERE login_usuario = '" + usuario + "'");
    if (rs1.next()) {
        nombre_empresa = rs1.getString("nombre_empresa");
    }
    switch (Integer.parseInt(opcion)) {
        case 1: //OBTIENE DATOS DE COMPROBANTES
            rs = dataSource.obtenerDato("SELECT "
                    + "'Cod:'||id_venta||' |Comprobante : '|| "
                    + "CASE WHEN id_timbrado = '' THEN 'Ticket' ELSE 'Factura' END||' |Nro Comprobante :'||nro_factura_venta"
                    + "||' |Fecha Comprobante :'||to_char(v.fecha_venta::date, 'DD/MM/YYYY') as datos "
                    + "FROM stock_facturacion.ventas v "
                    + "LEFT JOIN stock_facturacion.tipos_pagos t on t.id_tipo_pago = v.id_tipo_pago "
                    + "WHERE estado_venta = 1");
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("datos") + "'>"
                        + rs.getString("datos")
                        + "</option>");
            }
            break;
        case 2://OBTIENE DATOS DE ARTICULOS
            rs = dataSource.obtenerDato("SELECT "
                    + "'Cod:'||id_articulo||' |Articulo : '||articulo_descripcion||' |Categoria :'||grupo_descripcion"
                    + " as datos "
                    + "FROM stock_facturacion.articulos v "
                    + "LEFT JOIN stock_facturacion.grupos t on t.id_grupo = v.id_grupo ");
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("datos") + "'>"
                        + rs.getString("datos")
                        + "</option>");
            }
            break;
        case 3:
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
                    + "'Cod :'||id_venta_manual||' |Nro Factura:'||nro_factura_venta||' |Fecha Venta:'||to_char(fecha_venta, 'DD/MM/YYYY')|| "
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
            break;
    }
    out.print(htmlDatos.toString());
    cn.desConectarBD();
%>
