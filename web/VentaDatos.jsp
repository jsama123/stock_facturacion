<%-- 
    Document   : MarcaDatos
    Created on : 3/06/2020, 10:08:25 PM
    Author     : Jose Samaniego
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
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

    Date fecha = new Date();
    DateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
    String fecha_actual = formato.format(fecha);

    DecimalFormat formatea = new DecimalFormat("###,###.##");

    String opcion = request.getParameter("opcion");
    String id = request.getParameter("id");
    String codigo_barra = request.getParameter("codigo_barra");
    String id_caja = request.getParameter("id_caja");
    String id_articulo = request.getParameter("id_articulo");
    String id_stock = request.getParameter("id_stock");
    String nombre_empresa = "";
    rs1 = dataSource.obtenerDato("SELECT nombre_empresa FROM usuarios WHERE login_usuario = '" + usuario + "'");
    if (rs1.next()) {
        nombre_empresa = rs1.getString("nombre_empresa");
    }
    switch (Integer.parseInt(opcion)) {
        case 1: //OBTIENE DATOS PARA LA GRILLA
            rs = dataSource.obtenerDato("SELECT "
                    + "id_venta, to_char(fecha_venta, 'YYYY/MM/DD') as fecha, "
                    + "descripcion_caja, "
                    + "CASE WHEN id_timbrado != '' THEN 'f' ELSE 't' END as id_timbrado, "
                    + "nombre_apellido_cajero, "
                    + "CASE WHEN estado_venta = 0 THEN 'CREADO' WHEN estado_venta = 1 THEN 'PROCESADO'"
                    + "WHEN estado_venta = 2 THEN 'ANULADO' END as estado, "
                    + "CASE WHEN id_timbrado !='' THEN 'FACTURA' ELSE 'TICKET' END as tipo_doc, "
                    + "ci_ruc_cliente||'-'||razon_social_cliente as cliente, "
                    + "CASE WHEN id_timbrado = '' THEN '-- ' ELSE COALESCE(nro_factura_venta, '--') END as nro_venta "
                    + "FROM stock_facturacion.ventas v "
                    + "LEFT JOIN stock_facturacion.cajeros c on c.id_cajero = v.id_cajero "
                    + "LEFT JOIN stock_facturacion.cajas c1 on c1.id_caja = v.id_caja "
                    + "LEFT JOIN stock_facturacion.clientes c2 on c2.id_cliente = v.id_cliente "
                    + "LEFT JOIN usuarios u on u.login_usuario = v.usu_alta "
                    + "WHERE nombre_empresa = '" + nombre_empresa + "' AND fecha_venta::date = '" + fecha_actual + "'"
                    + " ORDER BY id_venta desc;");
            while (rs.next()) {
                htmlDatos.append("<tr>"
                        + "<td>" + rs.getString("fecha") + "</td>"
                        + "<td>" + rs.getString("nombre_apellido_cajero") + "</td>"
                        + "<td>" + rs.getString("cliente") + "</td>"
                        + "<td>" + rs.getString("tipo_doc") + "</td>"
                        + "<td>" + rs.getString("nro_venta") + "</td>"
                        + "<td>" + rs.getString("estado") + "</td>");
                if (rs.getString("estado").equals("CREADO")) {
                    htmlDatos.append("<td><img src='imagenes/edit.png' style='cursor:pointer' onclick=\"abrirFormulario('modificar', " + rs.getString("id_venta") + ")\" "
                            + "data-toggle='modal' data-target='#modalForm'></td>"
                            + "<td><img src='imagenes/delete.png' style='cursor:pointer' onclick=\"abrirFormulario('eliminar', " + rs.getString("id_venta") + ")\" "
                            + "data-toggle='modal' data-target='#modalForm'></td>");
                    htmlDatos.append("<td><img src='imagenes/money.png' style='cursor:pointer' onclick=\"abrirDetalle(" + rs.getString("id_venta") + ")\" "
                            + "data-toggle='modal' data-target='#modalDetalleVenta'></td>");
                } else {
                    htmlDatos.append("<td><img src='imagenes/block.png' style='cursor:pointer' title='BLOQUEADO'></td>"
                            + "<td><img class='imgGrid' src='imagenes/block.png' style='cursor:pointer' title='BLOQUEADO'></td>"
                            + "<td><img class='imgGrid' src='imagenes/block.png' style='cursor:pointer' title='BLOQUEADO'></td>");
                }
                htmlDatos.append("<td><img src='imagenes/print.png' style='cursor:pointer' onclick=\"imprimir(" + rs.getString("id_venta") + ", '" + rs.getString("id_timbrado") + "')\" "
                        + "data-toggle='modal' data-target='#'></td>"
                        + "</tr>");
            }
            break;
        case 2: //OBTIENE DATOS PARA EL CAMPO DINAMICO DE CLIENTES
            rs = dataSource.obtenerDato("SELECT id_cliente||'/'||ci_ruc_cliente||'-'||razon_social_cliente as cliente FROM stock_facturacion.clientes;");
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("cliente") + "'>"
                        + rs.getString("cliente")
                        + "</option>");
            }
            break;
        case 3: //OBTIENE DATOS PARA EL COMBO DE CAJAS
            rs = dataSource.obtenerDato("SELECT id_caja, descripcion_caja "
                    + "FROM stock_facturacion.cajas a "
                    + "LEFT JOIN usuarios u on u.login_usuario = a.usu_alta "
                    + "WHERE nombre_empresa = '" + nombre_empresa + "' ");
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("id_caja") + "'>" + rs.getString("descripcion_caja") + "</option>");
            }
            break;
        case 4: //OBTIENE DATOS PARA EL COMBO DE CAJEROS
            rs = dataSource.obtenerDato("SELECT id_cajero, nombre_apellido_cajero "
                    + "FROM stock_facturacion.cajeros a "
                    + "LEFT JOIN usuarios u on u.login_usuario = a.usu_alta "
                    + "WHERE nombre_empresa = '" + nombre_empresa + "' ");
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("id_cajero") + "'>" + rs.getString("nombre_apellido_cajero") + "</option>");
            }
            break;
        case 5: //VALIDA SI EXISTE UN ARQUEO DE CAJA ABIERTO EN LA FECHA ACTUAL 
            String retorno;
            rs = dataSource.obtenerDato("SELECT  "
                    + "id_arqueo_caja "
                    + "FROM stock_facturacion.arqueo_caja "
                    + "WHERE estado_arqueo_caja = 0 AND id_caja = " + id_caja + " AND fecha_inicio_arqueo_caja::date = '" + fecha_actual + "'");
            if (rs.next()) {
                retorno = "s";
            } else {
                retorno = "n";
            }
            htmlDatos.append(retorno);
            break;
        case 6: //OBTIENE DATOS PARA LOS CAMPOS DEL FORMULARIO 
            rs = dataSource.obtenerDato("SELECT "
                    + "v.id_cliente||'/'||ci_ruc_cliente||'-'||razon_social_cliente||','||id_caja||','||id_cajero||','||to_char(fecha_venta, 'DD/MM/YYYY')||','||id_venta||','||tipo_venta as datos "
                    + "FROM stock_facturacion.ventas v "
                    + "LEFT JOIN stock_facturacion.clientes c on c.id_cliente = v.id_cliente "
                    + "WHERE id_venta =  " + id);
            if (rs.next()) {
                htmlDatos.append(rs.getString("datos"));
            }
            break;
        case 7: //OBTIENE DATOS PARA EL DATA LIST DE ARTICULOS
            rs = dataSource.obtenerDato("SELECT "
                    + "'Cod: '||id_articulo||' |Art :'||articulo_descripcion||' |Impuesto :'||porcentaje_impuesto"
                    + "||' |Cod Barra :'||codigo_barra as articulo "
                    + "FROM stock_facturacion.articulos a  "
                    //+ "LEFT JOIN stock_facturacion.articulos a on a.id_articulo = s.id_articulo "
                    //+ "LEFT JOIN stock_facturacion.articulo_costos ac on ac.id_articulo_costo = s.id_articulo_costo "
                    //+ "LEFT JOIN stock_facturacion.depositos_sucursales d on d.id_deposito_sucursal = s.id_deposito_sucursal "
                    + "LEFT JOIN stock_facturacion.impuestos i on i.id_impuesto = a.id_impuesto "
                    + "WHERE id_articulo IN ( "
                    + "SELECT id_articulo "
                    + "FROM stock_facturacion.stocks "
                    + "WHERE existencia > 0) AND a.id_articulo NOT IN ("
                    + "SELECT s.id_articulo "
                    + "FROM stock_facturacion.ventas_detalles vd "
                    + "LEFT JOIN stock_facturacion.stocks s on s.id_stock = vd.id_stock "
                    + "WHERE vd.id_venta = "+id+")");
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("articulo") + "'>"
                        + rs.getString("articulo")
                        + "</option>");
            }
            break;
        case 8://OBTIENE DATOS PARA DETALLES DE VENTAS
            rs = dataSource.obtenerDato("SELECT "
                    + "id_venta_detalle, "
                    + "articulo_descripcion, "
                    + "cantidad_venta, "
                    + "CASE WHEN es_desc_gs_venta THEN precio_unitario::int-descuento_gs_venta "
                    + "ELSE precio_unitario::int-(precio_unitario::int*descuenta_venta/100)::int END as precio_unitario, "
                    + "CASE WHEN es_desc_gs_venta THEN descuento_gs_venta ELSE COALESCE(descuenta_venta, 0) END as descuenta_venta, "
                    + "CASE WHEN es_desc_gs_venta THEN cantidad_venta*(precio_unitario::int-descuento_gs_venta) "
                    + "ELSE cantidad_venta*(precio_unitario::int-(precio_unitario::int*descuenta_venta/100)::int) END as sub_total "
                    + "FROM stock_facturacion.ventas_detalles v "
                    + "LEFT JOIN stock_facturacion.stocks s on s.id_stock = v.id_stock "
                    + "LEFT JOIN stock_facturacion.articulos a on a.id_articulo = s.id_articulo "
                    + "WHERE v.id_venta = " + id);
            while (rs.next()) {
                htmlDatos.append("<tr>"
                        + "<td>" + rs.getString("articulo_descripcion") + "</td>"
                        + "<td>" + rs.getString("cantidad_venta") + "</td>"
                        + "<td>" + formatea.format(Double.valueOf(rs.getString("descuenta_venta"))) + "</td>"
                        + "<td>" + formatea.format(Double.valueOf(rs.getString("precio_unitario"))) + "</td>"
                        + "<td>" + formatea.format(Double.valueOf(rs.getString("sub_total"))) + "</td>"
                        + "<td><img class='imgGrid' src='imagenes/delete.png' style='cursor:pointer' "
                        + "onclick=\"accionProcesoDetalleVenta(3, " + rs.getString("id_venta_detalle") + ")\"></td>"
                        + "</tr>");
            }
            break;
        case 9://OBTIENE DATOS PARA COMBO TIPO DE PAGOS
            rs = dataSource.obtenerDato("SELECT id_tipo_pago, descripcion_tipo_pago "
                    + "FROM stock_facturacion.tipos_pagos;");
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("id_tipo_pago") + "'>"
                        + rs.getString("descripcion_tipo_pago")
                        + "</option>");
            }
            break;
        case 10://OBTIENE DATOS PARA LA TABLA DE PAGOS REGISTRADOS
            rs = dataSource.obtenerDato("SELECT v.id_tipo_pago, COALESCE(descripcion_tipo_pago, 'SIN PAGO REGISTRADO') as descripcion_tipo_pago, "
                    + "COALESCE(monto_pago::int, 0) as monto_pago "
                    + "FROM stock_facturacion.ventas v  "
                    + "LEFT JOIN stock_facturacion.tipos_pagos t on t.id_tipo_pago = v.id_tipo_pago "
                    + "WHERE id_venta = " + id);
            while (rs.next()) {
                htmlDatos.append("<tr>"
                        + "<td id='tdDescriPago'>" + rs.getString("descripcion_tipo_pago") + "</td>"
                        + "<td>" + formatea.format(Double.valueOf(rs.getString("monto_pago"))) + "</td>"
                        + "<td><img class='imgGrid' src='imagenes/edit.png' style='cursor:pointer' "
                        + "onclick=\"completarCamposPago(" + rs.getString("id_tipo_pago") + ", " + rs.getString("monto_pago") + ")\"></td>"
                        + "</tr>");
            }
            break;
        case 11: //OBTIENE ULTIMO NRO DE TICKET
            String retorno1;
            rs = dataSource.obtenerDato("SELECT "
                    + "COALESCE(max(numero_ticket_venta), 0)+1 as ticket "
                    + "FROM stock_facturacion.ventas");
            if (rs.next()) {
                htmlDatos.append(rs.getString("ticket"));
            }
            break;
        case 12: //OBTIENE DATOS PARA COMBO DE DESCUENTO
            rs = dataSource.obtenerDato("SELECT porcentaje_lista_precio, descripcion_lista_precio "
                    + "FROM stock_facturacion.lista_precios "
                    + "ORDER BY 1 asc ");
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("porcentaje_lista_precio") + "'>"
                        + rs.getString("descripcion_lista_precio") + " - Desc : " + rs.getString("porcentaje_lista_precio") + " %"
                        + "</option>");
            }
            break;
        case 13: //OBTIENE DATOS PARA LA TABLA DESCUENTOS
            rs = dataSource.obtenerDato("SELECT id_venta, COALESCE(descripcion_lista_precio, 'SIN DESCUENTO REGISTRADO') as descripcion_lista_precio, "
                    + "COALESCE(descuento_aplicado, 0) as descuento_aplicado "
                    + "FROM stock_facturacion.ventas v  "
                    + "LEFT JOIN stock_facturacion.lista_precios t on t.porcentaje_lista_precio = v.descuento_aplicado "
                    + "WHERE id_venta = " + id);
            while (rs.next()) {
                htmlDatos.append("<tr>"
                        + "<td>" + rs.getString("descripcion_lista_precio") + "</td>"
                        + "<td id='tdDescVenta'>" + rs.getString("descuento_aplicado") + "</td>"
                        + "</tr>");
            }
            break;
        case 14: //OBTIENE EL TIPO DE PAGO POR ID DE VENTA
            rs = dataSource.obtenerDato("SELECT "
                    + "COALESCE(id_tipo_pago, 0) as tipo_pago "
                    + "FROM stock_facturacion.ventas "
                    + "WHERE id_venta = " + id);
            if (rs.next()) {
                htmlDatos.append(rs.getString("tipo_pago"));
            }
            break;
        case 15: //OBTIENE EL ID TIMBRADO DE UNA VENTA 
            rs = dataSource.obtenerDato("SELECT "
                    + "id_timbrado  "
                    + "FROM stock_facturacion.ventas "
                    + "WHERE id_venta = " + id);
            if (rs.next()) {
                htmlDatos.append(rs.getString("id_timbrado"));
            }
            break;
        case 16://PARA BUSQUEDA POR CODIGO DE BARRA
            /*rs = dataSource.obtenerDato("SELECT "
                    + "'Cod:'||id_stock||' |Art :'||articulo_descripcion"
                    + "||' |Existencia :'||existencia::int||' |Impuesto :'||porcentaje_impuesto as articulo "
                    //+ "||' |Cod Barra :'||codigo_barra as articulo "
                    + "FROM stock_facturacion.stocks s  "
                    + "LEFT JOIN stock_facturacion.depositos_sucursales d on d.id_deposito_sucursal = s.id_deposito_sucursal "
                    + "LEFT JOIN stock_facturacion.articulos a on a.id_articulo = s.id_articulo "
                    + "LEFT JOIN stock_facturacion.impuestos i on i.id_impuesto = a.id_impuesto "
                    + "WHERE id_stock NOT IN ( "
                    + "SELECT id_stock "
                    + "FROM stock_facturacion.ventas_detalles  "
                    + "WHERE id_venta = " + id + ") AND s.existencia > 0 AND deposito_comercial AND a.codigo_barra='" + codigo_barra + "'");*/
            rs = dataSource.obtenerDato("SELECT "
                    + "'Cod: '||id_articulo||' |Art :'||articulo_descripcion||' |Impuesto :'||porcentaje_impuesto"
                    + "||' |Cod Barra :'||codigo_barra as articulo "
                    + "FROM stock_facturacion.articulos a  "
                    //+ "LEFT JOIN stock_facturacion.articulos a on a.id_articulo = s.id_articulo "
                    //+ "LEFT JOIN stock_facturacion.articulo_costos ac on ac.id_articulo_costo = s.id_articulo_costo "
                    //+ "LEFT JOIN stock_facturacion.depositos_sucursales d on d.id_deposito_sucursal = s.id_deposito_sucursal "
                    + "LEFT JOIN stock_facturacion.impuestos i on i.id_impuesto = a.id_impuesto "
                    + "WHERE id_articulo IN ( "
                    + "SELECT id_articulo "
                    + "FROM stock_facturacion.stocks "
                    + "WHERE existencia > 0) AND a.id_articulo NOT IN ("
                    + "SELECT s.id_articulo "
                    + "FROM stock_facturacion.ventas_detalles vd "
                    + "LEFT JOIN stock_facturacion.stocks s on s.id_stock = vd.id_stock "
                    + "WHERE vd.id_venta = "+id+") AND a.codigo_barra='" + codigo_barra + "'");
            if (rs.next()) {
                htmlDatos.append(rs.getString("articulo"));
            } else {
                htmlDatos.append("SIN REGISTRO");
            }
            break;
        case 17://VALIDA SI LA CANTIDAD ASIGNADA ES SUPERIOR A LA EXISTENCIA
            rs = dataSource.obtenerDato("SELECT "
                    + "articulo_descripcion||' ---> Cant. Asignada :'||vd.cantidad_venta||'; Existencia : '||s.existencia::int as articulo_datos "
                    + "FROM stock_facturacion.ventas_detalles vd  "
                    + "LEFT JOIN stock_facturacion.stocks s on s.id_stock = vd.id_stock "
                    + "LEFT JOIN stock_facturacion.depositos_sucursales ds on ds.id_deposito_sucursal = s.id_deposito_sucursal "
                    + "LEFT JOIN stock_facturacion.articulos a on a.id_articulo = s.id_articulo "
                    + "WHERE vd.id_venta = " + id + " AND vd.cantidad_venta > s.existencia AND deposito_comercial");
            if (rs.next()) {
                htmlDatos.append("s");
            } else {
                htmlDatos.append("n");
            }
            break;
        case 18:
            rs = dataSource.obtenerDato("SELECT "
                    + "'/ '||articulo_descripcion||' ---> Cant. Asignada :'||vd.cantidad_venta||'; Existencia : '||s.existencia::int as articulo_datos "
                    + "FROM stock_facturacion.ventas_detalles vd  "
                    + "LEFT JOIN stock_facturacion.stocks s on s.id_stock = vd.id_stock "
                    + "LEFT JOIN stock_facturacion.depositos_sucursales ds on ds.id_deposito_sucursal = s.id_deposito_sucursal "
                    + "LEFT JOIN stock_facturacion.articulos a on a.id_articulo = s.id_articulo "
                    + "WHERE vd.id_venta = " + id + " AND vd.cantidad_venta > s.existencia AND deposito_comercial");
            while (rs.next()) {
                htmlDatos.append(rs.getString("articulo_datos"));
            }
            break;
        case 19://OBTIENE DATOS PARA VENTAS PENDIENTES DE PROCESAR
            rs = dataSource.obtenerDato("SELECT "
                    + "id_venta, to_char(fecha_venta, 'YYYY/MM/DD') as fecha, "
                    + "descripcion_caja, "
                    + "CASE WHEN id_timbrado != '' THEN 'f' ELSE 't' END as id_timbrado, "
                    + "nombre_apellido_cajero, "
                    + "CASE WHEN estado_venta = 0 THEN 'CREADO' WHEN estado_venta = 1 THEN 'PROCESADO'"
                    + "WHEN estado_venta = 2 THEN 'ANULADO' END as estado, "
                    + "CASE WHEN id_timbrado !='' THEN 'FACTURA' ELSE 'TICKET' END as tipo_doc, "
                    + "ci_ruc_cliente||'-'||razon_social_cliente as cliente, "
                    + "CASE WHEN id_timbrado = '' THEN '-- ' ELSE COALESCE(nro_factura_venta, '--') END as nro_venta "
                    + "FROM stock_facturacion.ventas v "
                    + "LEFT JOIN stock_facturacion.cajeros c on c.id_cajero = v.id_cajero "
                    + "LEFT JOIN stock_facturacion.cajas c1 on c1.id_caja = v.id_caja "
                    + "LEFT JOIN stock_facturacion.clientes c2 on c2.id_cliente = v.id_cliente "
                    + "LEFT JOIN usuarios u on u.login_usuario = v.usu_alta "
                    + "WHERE estado_venta = 0"
                    + " ORDER BY id_venta desc;");
            while (rs.next()) {
                htmlDatos.append("<tr>"
                        + "<td>" + rs.getString("fecha") + "</td>"
                        + "<td>" + rs.getString("nombre_apellido_cajero") + "</td>"
                        + "<td>" + rs.getString("cliente") + "</td>"
                        + "<td>" + rs.getString("tipo_doc") + "</td>"
                        + "<td>" + rs.getString("nro_venta") + "</td>"
                        + "<td>" + rs.getString("estado") + "</td>");
                if (rs.getString("estado").equals("CREADO")) {
                    htmlDatos.append("<td><img src='imagenes/edit.png' style='cursor:pointer' onclick=\"abrirFormulario('modificar', " + rs.getString("id_venta") + ")\" "
                            + "data-toggle='modal' data-target='#modalForm'></td>"
                            + "<td><img src='imagenes/delete.png' style='cursor:pointer' onclick=\"abrirFormulario('eliminar', " + rs.getString("id_venta") + ")\" "
                            + "data-toggle='modal' data-target='#modalForm'></td>");
                    htmlDatos.append("<td><img src='imagenes/money.png' style='cursor:pointer' onclick=\"abrirDetalle(" + rs.getString("id_venta") + ")\" "
                            + "data-toggle='modal' data-target='#modalDetalleVenta'></td>");
                } else {
                    htmlDatos.append("<td><img src='imagenes/block.png' style='cursor:pointer' title='BLOQUEADO'></td>"
                            + "<td><img class='imgGrid' src='imagenes/block.png' style='cursor:pointer' title='BLOQUEADO'></td>"
                            + "<td><img class='imgGrid' src='imagenes/block.png' style='cursor:pointer' title='BLOQUEADO'></td>");
                }
                htmlDatos.append("<td><img src='imagenes/print.png' style='cursor:pointer' onclick=\"imprimir(" + rs.getString("id_venta") + ", '" + rs.getString("id_timbrado") + "')\" "
                        + "data-toggle='modal' data-target='#'></td>"
                        + "</tr>");
            }
            break;
        case 20:// OBTIENE DATOS DE CUOTAS PARA VENTAS A CREDITO
            rs = dataSource.obtenerDato("SELECT cantidad_cuota, 'Cantidad Cuotas :'||cantidad_cuota||'- Interes Mensual:'||interes_mensual||'%' as descri "
                    + "FROM stock_facturacion.parametros_cuotas_ventas;");
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("cantidad_cuota") + "'>"
                        + rs.getString("descri")
                        + "</option>");
            }
            break;
        case 21://COSTO DE VENTAS POR ID
            rs = dataSource.obtenerDato("SELECT max(id_stock)||'-'||max(costo_venta::int) as valorCostos, max(costo_venta::int) as costo_ventas "
                    + "FROM stock_facturacion.stocks s "
                    + "LEFT JOIN stock_facturacion.articulo_costos ac on ac.id_articulo_costo = s.id_articulo_costo "
                    + "LEFT JOIN stock_facturacion.depositos_sucursales s1 on s1.id_deposito_sucursal = s.id_deposito_sucursal "
                    + "WHERE s.existencia > 0 AND deposito_comercial AND s.id_articulo = "+id_articulo
                    + " GROUP BY s.id_articulo_costo");
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("valorCostos") + "'>"
                        + rs.getString("costo_ventas")
                        + "</option>");
            }
            break;
        case 22://OBTIENE DATOS DE EXISTENCIAS POR COSTOS EN BASE AL ID ARTICULO
            rs = dataSource.obtenerDato("SELECT existencia::int "
                    + "FROM stock_facturacion.stocks s "
                    //+ "LEFT JOIN stock_facturacion.depositos_sucursales s1 on s1.id_deposito_sucursal = s.id_deposito_sucursal "
                    + "WHERE s.id_stock = "+id_stock);
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("existencia") + "'>"
                        + rs.getString("existencia")
                        + "</option>");
                }
            break;
    }
    out.print(htmlDatos.toString());
    cn.desConectarBD();
%>
