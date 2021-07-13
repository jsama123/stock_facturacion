<%-- 
    Document   : MarcaDatos
    Created on : 3/06/2020, 10:08:25 PM
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
        case 1: //DATOS PARA LA GRILLA
            rs = dataSource.obtenerDato("SELECT "
                    + "'Cod:'||id_compra||' |Nro Comprobante :'||nro_factura_compra"
                    + "||' |Fecha Comprobante :'||to_char(v.fecha_compra, 'DD/MM/YYYY') as datos "
                    + "FROM stock_facturacion.compras v "
                    + "WHERE estado_compra = 1 ");
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("datos") + "'>"
                        + rs.getString("datos")
                        + "</option>");
            }
            break;
        case 2: //DATOS PARA EL LIST DE CLIENTES
            rs = dataSource.obtenerDato("SELECT "
                    + "COALESCE(nro_factura_compra, '--') as nro_factura_compra, "
                    + "nombre_apellido_cajero, "
                    + "to_char(fecha_compra, 'DD/MM/YYYY')as fecha, "
                    + "iva_aplicado, "
                    + "ci_ruc_proveedor, "
                    + "razon_social_proveedor, "
                    + "vd.id_stock, "
                    + "cantidad_compra, "
                    + "costo_unitario::int, "
                    + "articulo_descripcion, "
                    + "cantidad_compra*costo_unitario::int as sub_total "
                    + "FROM stock_facturacion.compras_detalles vd "
                    + "LEFT JOIN stock_facturacion.stocks s on vd.id_stock = s.id_stock "
                    + "LEFT JOIN stock_facturacion.articulos a on a.id_articulo = s.id_articulo "
                    + "LEFT JOIN stock_facturacion.compras v on v.id_compra = vd.id_compra "
                    + "LEFT JOIN stock_facturacion.proveedores c1 on c1.id_proveedor = v.id_proveedor "
                    + "LEFT JOIN stock_facturacion.cajeros c on c.id_cajero = v.id_cajero "
                    + "WHERE vd.id_compra =" + id);
            while (rs.next()) {
                htmlDatos.append(""
                        + "<tr>"
                        + "<td>" + rs.getString("articulo_descripcion") + "</td>"
                        + "<td>" + rs.getString("cantidad_compra") + "</td>"
                        + "<td>" + rs.getString("costo_unitario") + "</td>"
                        + "<td>" + rs.getString("sub_total") + "</td>"
                        + "</tr>");
            }
            break;
        case 3: // DATOS PARA OBTENER CAMPOS DEL FORMULARIO
            rs = dataSource.obtenerDato("SELECT id_nota_credito||','||n.id_cliente||'/'||ci_ruc_cliente||'-'||razon_social_cliente||','||concepto_nota_credito as datos "
                    + "FROM stock_facturacion.nota_creditos n "
                    + "LEFT JOIN stock_facturacion.clientes c on c.id_cliente = n.id_cliente "
                    + "WHERE id_nota_credito = " + id);
            if (rs.next()) {
                htmlDatos.append(rs.getString("datos"));
            }
            break;
        case 4: // DATOS PARA EL LIST DE VENTAS
            rs = dataSource.obtenerDato("SELECT "
                    + "'Cod:'||id_venta||' |Comprobante : '|| "
                    + "CASE WHEN id_timbrado = '' THEN 'Ticket' ELSE 'Factura' END||' |Nro Comprobante :'||nro_factura_venta"
                    + "||' |Fecha Comprobante :'||to_char(v.fecha_venta::date, 'DD/MM/YYYY') as datos "
                    + "FROM stock_facturacion.ventas v "
                    + "LEFT JOIN stock_facturacion.tipos_pagos t on t.id_tipo_pago = v.id_tipo_pago "
                    + "WHERE estado_venta = 1 AND descripcion_tipo_pago = 'EFECTIVO'");
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("datos") + "'>"
                        + rs.getString("datos")
                        + "</option>");
            }
            break;
        case 5: // DATOS PARA GRIILA DE ITEMS PROCESADOS A VENTA SELECCIONADO EN EL LIST DE VENTAS
            rs = dataSource.obtenerDato("SELECT "
                    + "vd.id_stock, "
                    + "articulo_descripcion, "
                    + "vd.cantidad_venta, "
                    + "precio_venta::int-(precio_venta::int*COALESCE(descuenta_venta, 0)/100)::int as precio_venta, "
                    + "cantidad_venta*(precio_venta::int-(precio_venta::int*COALESCE(descuenta_venta, 0)/100)::int) as sub_total "
                    + "FROM stock_facturacion.ventas_detalles vd "
                    + "LEFT JOIN stock_facturacion.stocks s on s.id_stock = vd.id_stock "
                    + "LEFT JOIN stock_facturacion.articulos a on a.id_articulo = s.id_articulo "
                    + "WHERE id_venta =" + id);
            while (rs.next()) {
                htmlDatos.append(""
                        + "<tr>"
                        + "<td><input type='checkbox' name='chkArticulosNota' onclick='checkear(\"ArticulosNota\")'  value='" + rs.getString("id_stock") + "' </td>"
                        + "<td>" + rs.getString("articulo_descripcion") + "</td>"
                        + "<td><input type='text' name='inputArtNota' size='2' value=" + rs.getString("cantidad_venta") + " id='txtCantArtNota'></td>"
                        + "<td>" + rs.getString("precio_venta") + "</td>"
                        + "<td>" + rs.getString("sub_total") + "</td>"
                        + "</tr>");
            }
            break;
        case 6: // DATOS PARA LA GRILLA DEL DETALLE
            rs = dataSource.obtenerDato("SELECT "
                    + "id_nota_credito_detalle, "
                    + "articulo_descripcion, "
                    + "cantidad_nota_credito, "
                    + "monto_nota_credito, "
                    + "cantidad_nota_credito*monto_nota_credito as sub_total "
                    + "FROM stock_facturacion.nota_creditos_detalle nd "
                    + "LEFT JOIN stock_facturacion.stocks s on s.id_stock = nd.id_stock "
                    + "LEFT JOIN stock_facturacion.articulos a on a.id_articulo = s.id_articulo "
                    + "WHERE id_nota_credito = " + id);
            while (rs.next()) {
                htmlDatos.append("<tr>"
                        + "<td>" + rs.getString("articulo_descripcion") + "</td>"
                        + "<td>" + rs.getString("cantidad_nota_credito") + "</td>"
                        + "<td>" + rs.getString("monto_nota_credito") + "</td>"
                        + "<td>" + rs.getString("sub_total") + "</td>"
                        + "<td><img class='imgGrid' src='imagenes/delete.png' style='cursor:pointer' "
                        + "onclick=\"accionProcesoDetalleNota(3, " + rs.getString("id_nota_credito_detalle") + ")\"></td>"
                        + "</tr>");
            }
            break;
        case 7: // OBTIENE EL ULTIMO NRO DE NOTA DE CREDITO
            rs = dataSource.obtenerDato("SELECT "
                    + "COALESCE(max(numero_nota_credito), 0) as nro_nc "
                    + "FROM stock_facturacion.nota_creditos");
            if (rs.next()) {
                htmlDatos.append(rs.getString("nro_nc"));
            }
            break;
        case 8: //OBTIENE ID VENTA A ANULAR
            rs = dataSource.obtenerDato("SELECT "
                    + "id_venta "
                    + "FROM stock_facturacion.nota_creditos_detalle nc "
                    + "WHERE id_nota_credito = " + id);
            if (rs.next()) {
                htmlDatos.append(rs.getString("id_venta"));
            }
            break;
        case 9: //OBTIENE FECHA NOTA DE GARANTIA
            rs = dataSource.obtenerDato("SELECT "
                    + "to_char(fecha_nota_credito::date, 'DD/MM/YYYY') as fecha_nota "
                    + "FROM stock_facturacion.nota_creditos nc "
                    + "WHERE id_nota_credito = " + id);
            if (rs.next()) {
                htmlDatos.append(rs.getString("fecha_nota"));
            }
            break;
        case 10: //OBTIENE DIA DE VENTAS GARANTIA PARAMETRIZADA
            rs = dataSource.obtenerDato("SELECT "
                    + "garantia_venta "
                    + "FROM stock_facturacion.parametros_sistema nc ");
            if (rs.next()) {
                htmlDatos.append(rs.getString("garantia_venta"));
            }
            break;
    }
    out.print(htmlDatos.toString());
    cn.desConectarBD();
%>
