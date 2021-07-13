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
    String id_deposito = request.getParameter("id_deposito");
    String nroFactura = request.getParameter("nroFactura");
    String id_caja = request.getParameter("id_caja");
    String nombre_empresa = "";
    String sql = "";
    rs1 = dataSource.obtenerDato("SELECT nombre_empresa FROM usuarios WHERE login_usuario = '" + usuario + "'");
    if (rs1.next()) {
        nombre_empresa = rs1.getString("nombre_empresa");
    }
    switch (Integer.parseInt(opcion)) {
        case 1: //OBTIENE DATOS PARA LA GRILLA
            rs = dataSource.obtenerDato("SELECT "
                    + "v.id_compra, "
                    + "v.id_deposito, "
                    + "to_char(fecha_compra, 'YYYY/MM/DD') as fecha, "
                    + "descripcion_caja, "
                    + "nombre_apellido_cajero, "
                    + "CASE WHEN estado_compra = 0 THEN 'CREADO' WHEN estado_compra = 1 THEN 'PROCESADO'  WHEN estado_compra=2 THEN 'ANULADO' END as estado, "
                    + "ci_ruc_proveedor||'-'||razon_social_proveedor as proveedor,"
                    + "nro_factura_compra,"
                    + "CASE WHEN tipo_compra = 'CRE' THEN 'CREDITO' ELSE 'CONTADO' END AS tipo_compra,"
                    + "COALESCE(k.datos_compra, '--') as datos_compra,"
                    + "COALESCE(saldo, 0)as saldo "
                    + "FROM stock_facturacion.compras v "
                    + "LEFT JOIN stock_facturacion.cajeros c on c.id_cajero = v.id_cajero "
                    + "LEFT JOIN stock_facturacion.cajas c1 on c1.id_caja = v.id_caja "
                    + "LEFT JOIN ("
                    + "SELECT DISTINCT  "
                    + "cd.id_compra, "
                    + "' TOTAL : '||max(c.monto_total_compra::int)||'  ENTREGADO : '||COALESCE(max(monto_entregado_compra::int), 0) "
                    + "||' SALDO : '||CASE WHEN max(tipo_compra)='CRE' THEN COALESCE(max(c.monto_total_compra::int) - max(monto_entregado_compra::int), 0)- COALESCE(max(total_cuota), 0) "
                    + "ELSE 0 END as datos_compra, "
                    + "COALESCE(sum(cantidad_compra*costo_unitario)::int - max(monto_entregado_compra::int), 0)- COALESCE(max(total_cuota), 0) as saldo "
                    + "FROM stock_facturacion.compras_detalles cd  "
                    + "LEFT JOIN stock_facturacion.compras c on c.id_compra = cd.id_compra "
                    + "LEFT JOIN ( "
                    + "SELECT "
                    + "id_compra, "
                    + "sum(monto_pagado_cuota)::int as total_cuota "
                    + "FROM stock_facturacion.cuotas_compras_credito  "
                    + "GROUP BY id_compra "
                    + ") k on k.id_compra = c.id_compra "
                    + "GROUP BY cd.id_compra) k on k.id_compra = v.id_compra "
                    + "LEFT JOIN stock_facturacion.proveedores p on p.id_proveedor = v.id_proveedor "
                    + "LEFT JOIN usuarios u on u.login_usuario = v.usu_alta "
                    + "WHERE nombre_empresa = '" + nombre_empresa + "' "
                    + "ORDER BY id_compra desc;");
            System.out.println(rs.toString());
            while (rs.next()) {
                htmlDatos.append("<tr>"
                        + "<td>" + rs.getString("fecha") + "</td>"
                        + "<td>" + rs.getString("tipo_compra") + "</td>"
                        + "<td>" + rs.getString("proveedor") + "</td>"
                        + "<td>" + rs.getString("nro_factura_compra") + "</td>"
                        + "<td>" + rs.getString("datos_compra") + "</td>"
                        + "<td>" + rs.getString("estado") + "</td>");
                if (rs.getString("estado").equals("CREADO")) {
                    htmlDatos.append("<td><img src='imagenes/edit.png' style='cursor:pointer' onclick=\"abrirFormulario('modificar', " + rs.getString("id_compra") + ")\" "
                            + "data-toggle='modal' data-target='#modalForm'></td>"
                            + "<td><img src='imagenes/delete.png' style='cursor:pointer' onclick=\"abrirFormulario('eliminar', " + rs.getString("id_compra") + ")\" "
                            + "data-toggle='modal' data-target='#modalForm'></td>"
                            + "<td><img src='imagenes/money.png' style='cursor:pointer' onclick=\"abrirDetalle(" + rs.getString("id_compra") + ", " + rs.getString("id_deposito") + ")\" "
                            + "data-toggle='modal' data-target='#modalDetalleCompra'></td>");
                    if (rs.getString("tipo_compra").equals("CREDITO")) {
                        if (rs.getString("saldo").equals("0")) {
                            htmlDatos.append("<td><img class='imgGrid' src='imagenes/block.png' style='cursor:pointer' title='BLOQUEADO'></td>");
                        } else {
                            htmlDatos.append("<td><img src='imagenes/money.png' style='cursor:pointer' onclick=\"abrirDetalle(" + rs.getString("id_compra") + ")\" "
                                    + "data-toggle='modal' data-target='#modalDetallePagos'></td>");
                        }
                    } else {
                        htmlDatos.append("<td><img class='imgGrid' src='imagenes/block.png' style='cursor:pointer' title='BLOQUEADO'></td>");
                    }
                } else {
                    htmlDatos.append("<td><img src='imagenes/edit.png' style='cursor:pointer' onclick=\"abrirFormulario('modificar', " + rs.getString("id_compra") + ")\" "
                            + "data-toggle='modal' data-target='#modalForm'></td>"
                            + "<td><img class='imgGrid' src='imagenes/block.png' style='cursor:pointer' title='BLOQUEADO'></td>"
                            + "<td><img class='imgGrid' src='imagenes/block.png' style='cursor:pointer' title='BLOQUEADO'></td>");
                    if (rs.getString("tipo_compra").equals("CREDITO")) {
                        if (rs.getString("saldo").equals("0")) {
                            htmlDatos.append("<td><img class='imgGrid' src='imagenes/block.png' style='cursor:pointer' title='BLOQUEADO'></td>");
                        } else {
                            htmlDatos.append("<td><img src='imagenes/money.png' style='cursor:pointer' onclick=\"abrirDetalle(" + rs.getString("id_compra") + ")\" "
                                    + "data-toggle='modal' data-target='#modalDetallePagos'></td>");
                        }
                    } else {
                        htmlDatos.append("<td><img class='imgGrid' src='imagenes/block.png' style='cursor:pointer' title='BLOQUEADO'></td>");
                    }
                }
                htmlDatos.append("<td><img src='imagenes/print.png' style='cursor:pointer' onclick=\"imprimir(" + rs.getString("id_compra") + ")\" "
                        + "data-toggle='modal' data-target='#'></td>"
                        + "</tr>");
            }
            break;
        case 2: //OBTIENE DATOS PARA EL CAMPO DINAMICO DE CLIENTES
            rs = dataSource.obtenerDato("SELECT id_proveedor||'/'||ci_ruc_proveedor||'-'||razon_social_proveedor as proveedor FROM stock_facturacion.proveedores;");
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("proveedor") + "'>"
                        + rs.getString("proveedor")
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
                    + "v.id_proveedor||'/'||ci_ruc_proveedor||'-'||razon_social_proveedor||','||id_caja||','||id_cajero||','||to_char(fecha_compra, 'DD/MM/YYYY')||','||id_compra||','||COALESCE(nro_factura_compra, '--')"
                    + "||','||tipo_compra||','||monto_entregado_compra||','||fecha_vencimiento_cuota_compra||','||cantidad_cuota_compra||','||id_deposito||','||COALESCE(timbrado_compra, '--') as datos "
                    + "FROM stock_facturacion.compras v "
                    + "LEFT JOIN stock_facturacion.proveedores c on c.id_proveedor = v.id_proveedor "
                    + "WHERE id_compra =  " + id);
            if (rs.next()) {
                htmlDatos.append(rs.getString("datos"));
            }
            break;
        case 7: //OBTIENE DATOS PARA EL DATA LIST DE ARTICULOS
            rs = dataSource.obtenerDato("SELECT "
                    + "'Cod:'||id_stock||' |Art :'||articulo_descripcion||' |Costo:'||costo_compra::int||' |Existencia :'||existencia::int||' |Impuesto :'||porcentaje_impuesto as articulo "
                    + "FROM stock_facturacion.stocks s  "
                    + "LEFT JOIN stock_facturacion.articulos a on a.id_articulo = s.id_articulo "
                    + "LEFT JOIN stock_facturacion.articulo_costos ac on ac.id_articulo_costo = s.id_articulo_costo "
                    + "LEFT JOIN stock_facturacion.impuestos i on i.id_impuesto = a.id_impuesto "
                    + "WHERE id_stock NOT IN ( "
                    + "SELECT id_stock "
                    + "FROM stock_facturacion.compras_detalles  "
                    + "WHERE id_compra = " + id + ") AND id_deposito_sucursal = "+id_deposito);
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("articulo") + "'>"
                        + rs.getString("articulo")
                        + "</option>");
            }
            break;
        case 8://OBTIENE DATOS PARA DETALLES DE COMPRAS
            rs = dataSource.obtenerDato("SELECT "
                    + "id_compra_detalle, "
                    + "articulo_descripcion, "
                    + "cantidad_compra, "
                    + "costo_unitario::int, "
                    + "cantidad_compra*costo_unitario::int as sub_total "
                    + "FROM stock_facturacion.compras_detalles v "
                    + "LEFT JOIN stock_facturacion.stocks s on s.id_stock = v.id_stock "
                    + "LEFT JOIN stock_facturacion.articulos a on a.id_articulo = s.id_articulo "
                    + "WHERE v.id_compra = " + id);
            while (rs.next()) {
                htmlDatos.append("<tr>"
                        + "<td>" + rs.getString("articulo_descripcion") + "</td>"
                        + "<td>" + rs.getString("cantidad_compra") + "</td>"
                        + "<td>" + formatea.format(Double.valueOf(rs.getString("costo_unitario"))) + "</td>"
                        + "<td>" + formatea.format(Double.valueOf(rs.getString("sub_total"))) + "</td>"
                        + "<td><img class='imgGrid' src='imagenes/delete.png' style='cursor:pointer' "
                        + "onclick=\"accionProcesoDetalleCompra(3, " + rs.getString("id_compra_detalle") + ")\"></td>"
                        + "</tr>");
            }
            break;

        case 9://OBTIENE DATOS DE TIPO DE COMPROBANTES
            rs = dataSource.obtenerDato("SELECT "
                    + "id_tipo_comprobante, "
                    + "descripcion_tipo_comprobante "
                    + "FROM stock_facturacion.tipos_comprobantes");
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("id_tipo_comprobante") + "'>"
                        + rs.getString("descripcion_tipo_comprobante")
                        + "</option>");
            }
            break;

        case 10://OBTIENE DATOS DE PAGOS REGISTRADOS DE CUOTAS COMPRA CREDITO
            rs = dataSource.obtenerDato("SELECT "
                    + "to_char(fecha_pago_cuota, 'DD/MM/YYYY')as fecha, "
                    + "id_cuota_compra_credito, "
                    + "descripcion_tipo_comprobante, "
                    + "nro_comprobante_pago_cuota, "
                    + "monto_pagado_cuota::int as monto "
                    + "FROM stock_facturacion.cuotas_compras_credito cc "
                    + "LEFT JOIN stock_facturacion.compras c on c.id_compra = cc.id_compra "
                    + "LEFT JOIN stock_facturacion.tipos_comprobantes tc on tc.id_tipo_comprobante = cc.id_tipo_comprobante "
                    + "WHERE cc.id_compra = " + id);
            while (rs.next()) {
                htmlDatos.append("<tr>"
                        + "<td>" + rs.getString("fecha") + "</td>"
                        + "<td>" + rs.getString("descripcion_tipo_comprobante") + "</td>"
                        + "<td>" + rs.getString("nro_comprobante_pago_cuota") + "</td>"
                        + "<td>" + formatea.format(Double.valueOf(rs.getString("monto"))) + "</td>"
                        + "<td><img class='imgGrid' src='imagenes/delete.png' style='cursor:pointer' "
                        + "onclick=\"accionProcesoCuotaCompra(3, " + rs.getString("id_cuota_compra_credito") + ")\"></td>"
                        + "</tr>");
            }
            break;

        case 11://OBTIENE DEPOSITOS
            rs = dataSource.obtenerDato("SELECT "
                    + "id_deposito_sucursal,  "
                    + "deposito_sucursal_descripcion "
                    + "FROM stock_facturacion.depositos_sucursales cc "
                    + "WHERE id_deposito_sucursal IN ("
                    + "SELECT id_deposito_sucursal "
                    + "FROM stock_facturacion.stocks)");
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("id_deposito_sucursal") + "'>"
                        + rs.getString("deposito_sucursal_descripcion")
                        + "</option>");
            }
            break;
        case 12:
            String retorno1 = "";
            rs = dataSource.obtenerDato("SELECT id_compra FROM stock_facturacion.compras "
                    + "WHERE nro_factura_compra = '"+nroFactura+"' AND estado_compra = 1");
            if(rs.next()){
                retorno1 = "s";
            }else{
                retorno1 = "n";
            }
            htmlDatos.append(retorno1);
            break;
        case 13://OBTIENE MONTO TOTAL DE COMPRA 
            rs = dataSource.obtenerDato("SELECT sum(costo_unitario::int*cantidad_compra) as monto "
                    + "FROM stock_facturacion.compras_detalles cd "
                    + "LEFT JOIN stock_facturacion.compras c on c.id_compra = cd.id_compra "
                    + "WHERE c.estado_compra = 1 AND c.id_compra = "+id);
            if(rs.next()){
                htmlDatos.append(rs.getString("monto"));
            }
            break;
    }
    out.print(htmlDatos.toString());
    cn.desConectarBD();
%>
