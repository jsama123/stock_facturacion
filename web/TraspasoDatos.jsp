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
    String id_deposito = request.getParameter("id_deposito");
    String nombre_empresa = "";
    rs1 = dataSource.obtenerDato("SELECT nombre_empresa FROM usuarios WHERE login_usuario = '" + usuario + "'");
    if (rs1.next()) {
        nombre_empresa = rs1.getString("nombre_empresa");
    }
    switch (Integer.parseInt(opcion)) {
        case 1:
            rs = dataSource.obtenerDato("SELECT "
                    + "id_traspaso, "
                    + "id_deposito_origen, "
                    + "d.deposito_sucursal_descripcion as destino, "
                    + "d1.deposito_sucursal_descripcion as origen, "
                    + "t.fecha, "
                    + "CASE WHEN estado = 0 THEN 'CREADO' WHEN estado = 1 THEN 'PROCESADO' ELSE 'ANULADO' END as estado "
                    + "FROM stock_facturacion.traspasos t "
                    + "LEFT JOIN stock_facturacion.depositos_sucursales d on d.id_deposito_sucursal = t.id_deposito_destino "
                    + "LEFT JOIN stock_facturacion.depositos_sucursales d1 on d1.id_deposito_sucursal = t.id_deposito_origen "
                    + "LEFT JOIN usuarios u on u.login_usuario = t.usu_alta "
                    + "WHERE nombre_empresa = '" + nombre_empresa + "' "
                    + "ORDER BY 1 asc;");
            while (rs.next()) {
                htmlDatos.append("<tr>"
                        + "<td>" + rs.getString("origen") + "</td>"
                        + "<td>" + rs.getString("destino") + "</td>"
                        + "<td>" + rs.getString("fecha") + "</td>"
                        + "<td>" + rs.getString("estado") + "</td>");
                if (rs.getString("estado").equals("CREADO")) {
                    htmlDatos.append("<td> <img src ='imagenes/edit.png'style ='cursor:pointer'onclick =\"abrirFormulario('modificar', " + rs.getString("id_traspaso") + ")\" "
                            + "data-toggle='modal' data-target='#modalForm'></td>"
                            + "<td><img src='imagenes/delete.png' style='cursor:pointer' onclick=\"abrirFormulario('eliminar', " + rs.getString("id_traspaso") + ")\" "
                            + "data-toggle='modal' data-target='#modalForm'></td>"
                            + "<td><img src='imagenes/money.png' style='cursor:pointer' onclick=\"abrirDetalle(" + rs.getString("id_traspaso") + ", " + rs.getString("id_deposito_origen") + ")\" "
                            + "data-toggle='modal' data-target='#modalDetalleTraspaso'></td>");
                } else {
                    htmlDatos.append("<td><img class='imgGrid' src='imagenes/block.png' style='cursor:pointer' title='BLOQUEADO'></td>"
                            + "<td><img class='imgGrid' src='imagenes/block.png' style='cursor:pointer' title='BLOQUEADO'></td>"
                            + "<td><img class='imgGrid' src='imagenes/block.png' style='cursor:pointer' title='BLOQUEADO'></td>");
                }
                htmlDatos.append("<td><img src='imagenes/print.png' style='cursor:pointer' onclick=\"imprimir(" + rs.getString("id_traspaso") + ")\" "
                        + "data-toggle='modal' data-target='#'></td>"
                        + "</tr>");
            }
            break;
        case 2:
            rs = dataSource.obtenerDato("SELECT id_deposito_sucursal, deposito_sucursal_descripcion "
                    + "FROM stock_facturacion.depositos_sucursales "
                    + "WHERE id_deposito_sucursal IN ("
                    + "SELECT id_deposito_sucursal "
                    + "FROM stock_facturacion.stocks)");
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("id_deposito_sucursal") + "'>"
                        + rs.getString("deposito_sucursal_descripcion")
                        + "</option>");
            }
            break;
        case 3:
            rs = dataSource.obtenerDato("SELECT id_deposito_sucursal, deposito_sucursal_descripcion "
                    + "FROM stock_facturacion.depositos_sucursales "
                    + "WHERE id_deposito_sucursal IN ("
                    + "SELECT id_deposito_sucursal "
                    + "FROM stock_facturacion.stocks)");
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("id_deposito_sucursal") + "'>"
                        + rs.getString("deposito_sucursal_descripcion")
                        + "</option>");
            }
            break;
        case 4:
            rs = dataSource.obtenerDato("SELECT id_traspaso||','||id_deposito_destino||','||id_deposito_origen||','||to_char(fecha, 'DD/MM/YYYY')||','||observacion as datos "
                    + "FROM stock_facturacion.traspasos "
                    + "WHERE id_traspaso = " + id);
            if (rs.next()) {
                htmlDatos.append(rs.getString("datos"));
            }
            break;
        case 5:
            rs = dataSource.obtenerDato("SELECT "
                    + "'Cod:'||id_stock||' |Art :'||articulo_descripcion||' |Costo:'||costo_articulo::int||' |Existencia :'||existencia::int as articulo "
                    + "FROM stock_facturacion.stocks s  "
                    + "LEFT JOIN stock_facturacion.articulos a on a.id_articulo = s.id_articulo "
                    + "LEFT JOIN stock_facturacion.impuestos i on i.id_impuesto = a.id_impuesto "
                    + "WHERE id_stock NOT IN ( "
                    + "SELECT id_stock "
                    + "FROM stock_facturacion.traspasos_detalles  "
                    + "WHERE id_traspaso = " + id + ") AND id_deposito_sucursal = " + id_deposito);
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("articulo") + "'>"
                        + rs.getString("articulo")
                        + "</option>");
            }
            break;
        case 6:
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
                        + "<td><img class='imgGrid' src='imagenes/delete.png' style='cursor:pointer' "
                        + "onclick=\"accionProcesoDetalleTraspaso(3, " + rs.getString("id_traspaso_detalle") + ")\"></td>"
                        + "</tr>");
            }
            break;
    }
    out.print(htmlDatos.toString());
    cn.desConectarBD();
%>
