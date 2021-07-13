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
            rs = dataSource.obtenerDato("SELECT  "
                    + "id_malogrado, "
                    + "deposito_sucursal_descripcion, "
                    + "articulo_descripcion, "
                    + "a.cantidad, "
                    + "motivo, "
                    + "CASE WHEN estado = 0 THEN 'CREADO' WHEN estado = 1 THEN 'PROCESADO' ELSE 'ANULADO' END as estado "
                    + "FROM stock_facturacion.malogrados a  "
                    + "LEFT JOIN stock_facturacion.stocks s on s.id_stock = a.id_stock "
                    + "LEFT JOIN stock_facturacion.depositos_sucursales ds on ds.id_deposito_sucursal = s.id_deposito_sucursal "
                    + "LEFT JOIN stock_facturacion.articulos b on b.id_articulo = s.id_articulo "
                    + "LEFT JOIN usuarios u on u.login_usuario = a.usu_alta "
                    + "WHERE nombre_empresa = '" + nombre_empresa + "'"
                    + "ORDER BY 1 asc;");
            while (rs.next()) {
                htmlDatos.append("<tr>"
                        + "<td>" + rs.getString("deposito_sucursal_descripcion") + "</td>"
                        + "<td>" + rs.getString("articulo_descripcion") + "</td>"
                        + "<td>" + rs.getString("cantidad") + "</td>"
                        + "<td>" + rs.getString("motivo") + "</td>"
                        + "<td>" + rs.getString("estado") + "</td>");
                if (rs.getString("estado").equals("CREADO")) {
                    htmlDatos.append("<td><img src='imagenes/edit.png' style='cursor:pointer' onclick=\"abrirFormulario('modificar', " + rs.getString("id_malogrado") + ")\" "
                            + "data-toggle='modal' data-target='#modalForm'></td>"
                            + "<td><img src='imagenes/delete.png' style='cursor:pointer' onclick=\"abrirFormulario('eliminar', " + rs.getString("id_malogrado") + ")\" "
                            + "data-toggle='modal' data-target='#modalForm'></td>"
                            + "<td><img src='imagenes/procesar.png' style='cursor:pointer; width:20px' onclick=\"aprobar(" + rs.getString("id_malogrado") + ")\"></td>"
                            + "</tr>");
                } else {
                    htmlDatos.append("<td><img class='imgGrid' src='imagenes/block.png' style='cursor:pointer' title='BLOQUEADO'></td>"
                            + "<td><img class='imgGrid' src='imagenes/block.png' style='cursor:pointer' title='BLOQUEADO'></td>"
                            + "<td><img class='imgGrid' src='imagenes/block.png' style='cursor:pointer' title='BLOQUEADO'></td>");
                }
            }
            break;
        case 2: //OBTIENE DATOS PARA EL CAMPO DINAMICO DE CLIENTES
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
            rs = dataSource.obtenerDato("SELECT "
                    + "'Cod:'||id_stock||' |Art :'||articulo_descripcion||' |Existencia :'||existencia::int as articulo "
                    + "FROM stock_facturacion.stocks s  "
                    + "LEFT JOIN stock_facturacion.articulos a on a.id_articulo = s.id_articulo "
                    + "WHERE id_deposito_sucursal = " + id_deposito);
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("articulo") + "'>"
                        + rs.getString("articulo")
                        + "</option>");
            }
            break;
        case 4:
            rs = dataSource.obtenerDato("SELECT  av.id_stock||','||av.motivo||','||observacion||','||cantidad"
                    + "||','||id_deposito_sucursal||','||'Cod:'||s.id_stock||' |Art :'||articulo_descripcion||' |Existencia :'||s.existencia::int as datos "
                    + "FROM stock_facturacion.malogrados av "
                    + "LEFT JOIN stock_facturacion.stocks s on s.id_stock = av.id_stock "
                    + "LEFT JOIN stock_facturacion.articulos a on a.id_articulo = s.id_articulo "
                    + "WHERE id_malogrado = "+id);
            if(rs.next()){
                htmlDatos.append(rs.getString("datos"));
            }
            break;
    }
    out.print(htmlDatos.toString());
    cn.desConectarBD();
%>
