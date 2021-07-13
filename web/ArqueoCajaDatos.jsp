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
    ResultSet rs2 = null;
    StringBuilder htmlDatos = new StringBuilder();
    fuenteDatos dataSource = new fuenteDatos();
    dataSource.setConexion(cn.getConexion());

    String opcion = request.getParameter("opcion");
    String id = request.getParameter("id");
    String nombre_empresa = "";
    String fecha_arqueo = "";
    rs1 = dataSource.obtenerDato("SELECT nombre_empresa FROM usuarios WHERE login_usuario = '" + usuario + "'");
    rs2 = dataSource.obtenerDato("SELECT fecha_inicio_arqueo_caja::date FROM stock_facturacion.arqueo_caja "
            + "WHERE estado_arqueo_caja = 0");
    if(rs2.next()){
        fecha_arqueo = rs2.getString("fecha_inicio_arqueo_caja");
    }
    if (rs1.next()) {
        nombre_empresa = rs1.getString("nombre_empresa");
    }
    switch (Integer.parseInt(opcion)) {
        case 1:
            rs = dataSource.obtenerDato("SELECT id_arqueo_caja, nombre_apellido_cajero, descripcion_caja, "
                    + "fecha_inicio_arqueo_caja, "
                    + "fecha_fin_arqueo_caja, "
                    + "CASE WHEN estado_arqueo_caja = 0 THEN 'ABIERTO' WHEN estado_arqueo_caja = 1 THEN 'CERRADO' END as estado, "
                    + "COALESCE(resultado_arqueo_caja::int, 0) as resultado_arqueo_caja "
                    + "FROM stock_facturacion.arqueo_caja a "
                    + "LEFT JOIN stock_facturacion.cajeros c on c.id_cajero = a.id_cajero "
                    + "LEFT JOIN stock_facturacion.cajas c1 on c1.id_caja = a.id_caja "
                    + "LEFT JOIN usuarios u on u.login_usuario = a.usu_alta "
                    + "WHERE nombre_empresa = '" + nombre_empresa + "' "
                    + " ORDER BY 1 asc");
            while (rs.next()) {
                htmlDatos.append("<tr>"
                        + "<td>" + rs.getString("nombre_apellido_cajero") + "</td>"
                        + "<td>" + rs.getString("descripcion_caja") + "</td>"
                        + "<td>" + rs.getString("fecha_inicio_arqueo_caja") + "</td>"
                        + "<td>" + rs.getString("fecha_fin_arqueo_caja") + "</td>"
                        + "<td>" + rs.getString("estado") + "</td>"
                        + "<td>" + rs.getString("resultado_arqueo_caja") + "</td>");
                if (rs.getString("estado").equals("ABIERTO")) {
                    htmlDatos.append("<td><img src='imagenes/edit.png' style='cursor:pointer' data-toggle='modal' data-target='#modalForm' onclick=\"abrirFormulario('modificar', " + rs.getString("id_arqueo_caja") + ")\"></td>"
                            + "<td><img class='imgGrid' src='imagenes/delete.png' style='cursor:pointer' onclick=\"abrirFormulario('eliminar', " + rs.getString("id_arqueo_caja") + ")\" "
                            + "data-toggle='modal' data-target='#modalForm'></td>"
                            + "<td><img class='imgGrid' src='imagenes/money.png' style='cursor:pointer' onclick=\"cargarDatos(6, 'cuerpoDetalleArqueo', " + rs.getString("id_arqueo_caja") + "); mostrarTotalArqueo(" + rs.getString("id_arqueo_caja") + ");\" "
                            + "data-toggle='modal' data-target='#modalDetalleArqueo'></td>"
                            + "<td><img class='imgGrid' src='imagenes/print.png' style='cursor:pointer' onclick=\"abrirFormulario('eliminar', " + rs.getString("id_arqueo_caja") + ")\" "
                            + "data-toggle='modal' data-target='#modalForm'></td>"
                            + "</tr>");
                }else{
                    htmlDatos.append("<td><img src='imagenes/block.png' style='cursor:pointer' title='BLOQUEADO'></td>"
                            + "<td><img class='imgGrid' src='imagenes/block.png' style='cursor:pointer' title='BLOQUEADO'></td>"
                            + "<td><img class='imgGrid' src='imagenes/block.png' style='cursor:pointer' title='BLOQUEADO'></td>"
                            + "<td><img class='imgGrid' src='imagenes/print.png' style='cursor:pointer' onclick=\"imprimir(" + rs.getString("id_arqueo_caja") + ")\"></td>"
                            + "</tr>");
                }

            }
            break;
        case 2:
            rs = dataSource.obtenerDato("SELECT id_cajero, nombre_apellido_cajero "
                    + "FROM stock_facturacion.cajeros a "
                    + "LEFT JOIN usuarios u on u.login_usuario = a.usu_alta "
                    + "WHERE nombre_empresa = '" + nombre_empresa + "' ");
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("id_cajero") + "'>" + rs.getString("nombre_apellido_cajero") + "</option>");
            }
            break;
        case 3:
            rs = dataSource.obtenerDato("SELECT id_caja, descripcion_caja "
                    + "FROM stock_facturacion.cajas a "
                    + "LEFT JOIN usuarios u on u.login_usuario = a.usu_alta "
                    + "WHERE nombre_empresa = '" + nombre_empresa + "' ");
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("id_caja") + "'>" + rs.getString("descripcion_caja") + "</option>");
            }
            break;
        case 4:
            String retorno;
            rs = dataSource.obtenerDato("SELECT id_arqueo_caja FROM stock_facturacion.arqueo_caja WHERE estado_arqueo_caja = 0");
            if (rs.next()) {
                retorno = "s";
            } else {
                retorno = "n";
            }
            htmlDatos.append(retorno);
            break;
        case 5:
            rs = dataSource.obtenerDato("SELECT id_cajero||','||id_caja||','||saldo_inicial_arqueo_caja::int as datos "
                    + "FROM stock_facturacion.arqueo_caja "
                    + "WHERE id_arqueo_caja = " + id);
            if (rs.next()) {
                htmlDatos.append(rs.getString("datos"));
            }
            break;
        case 6:
            rs = dataSource.obtenerDato("SELECT id_arqueo_caja_detalle, cantidad, denominacion,  "
                    + "cantidad*denominacion as sub_total "
                    + "FROM stock_facturacion.arqueo_caja_detalle "
                    + "WHERE id_arqueo_caja = " + id);
            while (rs.next()) {
                htmlDatos.append("<tr>"
                        + "<td>" + rs.getString("cantidad") + "</td>"
                        + "<td>" + rs.getString("denominacion") + "</td>"
                        + "<td>" + rs.getString("sub_total") + "</td>"
                        + "<td><img class='imgGrid' src='imagenes/delete.png' style='cursor:pointer' "
                        + "onclick=\"accionProcesoDetalle(3, " + rs.getString("id_arqueo_caja_detalle") + ")\"></td>"
                        + "</tr>");
            }
            break;
        case 7:
            rs = dataSource.obtenerDato("SELECT saldo_inicial_arqueo_caja FROM stock_facturacion.arqueo_caja WHERE id_arqueo_caja = " + id);
            if (rs.next()) {
                htmlDatos.append(rs.getString("saldo_inicial_arqueo_caja"));
            }
            break;
        case 8:
            rs = dataSource.obtenerDato("SELECT id_venta FROM stock_facturacion.ventas "
                    + "WHERE estado_venta = 0 AND fecha_venta::date = '"+fecha_arqueo+"'");
            if(rs.next()){
                retorno = "s";
            }else{
                retorno = "n";
            }
            htmlDatos.append(retorno);
            break;
    }
    out.print(htmlDatos.toString());
    cn.desConectarBD();
%>
