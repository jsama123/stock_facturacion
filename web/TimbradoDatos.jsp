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
        case 1:
            rs = dataSource.obtenerDato("SELECT id_timbrado, numero_timbrado, to_char(fecha_inicio_timbrado, 'DD/MM/YYYY') as fecha_inicio, "
                    + "to_char(fecha_fin_timbrado, 'DD/MM/YYYY') as fecha_fin, "
                    + " CASE WHEN estado = 0 THEN 'VIGENTE'"
                    + "      WHEN estado = 1 THEN 'NO VIGENTE'"
                    + " END as estado "
                    + " FROM stock_facturacion.timbrados a "
                    + "LEFT JOIN usuarios u on u.login_usuario = a.usu_alta "
                    + "WHERE nombre_empresa = '" + nombre_empresa + "' "
                    + "ORDER BY 1 asc;");
            while (rs.next()) {
                htmlDatos.append("<tr>"
                        + "<td>" + rs.getString("id_timbrado") + "</td>"
                        + "<td>" + rs.getString("numero_timbrado") + "</td>"
                        + "<td>" + rs.getString("fecha_inicio") + "</td>"
                        + "<td>" + rs.getString("fecha_fin") + "</td>"
                        + "<td>" + rs.getString("estado") + "</td>");
                if (rs.getString("estado").equals("VIGENTE")) {
                    htmlDatos.append("<td><img src='imagenes/edit.png' style='cursor:pointer' onclick=\"abrirFormulario('modificar', " + rs.getString("id_timbrado") + ")\" "
                            + "data-toggle='modal' data-target='#modalForm'></td>"
                            + "<td><img src='imagenes/delete.png' style='cursor:pointer' onclick=\"abrirFormulario('eliminar', " + rs.getString("id_timbrado") + ")\" "
                            + "data-toggle='modal' data-target='#modalForm'></td>"
                            + "</tr>");
                } else {
                    htmlDatos.append("<td><img src='imagenes/block.png' title='BLOQUEADO'></td>"
                            + "<td><img src='imagenes/block.png' title='BLOQUEADO'></td>"
                            + "</tr>");
                }

            }
            break;
        case 2:
            rs = dataSource.obtenerDato("SELECT id_timbrado||'-'||numero_timbrado||'-'||to_char(fecha_inicio_timbrado, 'DD/MM/YYYY')||'-'||"
                    + "to_char(fecha_fin_timbrado, 'DD/MM/YYYY') as datos FROM stock_facturacion.timbrados WHERE id_timbrado = " + id);
            if (rs.next()) {
                htmlDatos.append(rs.getString("datos"));
            }
            break;
        case 3:
            rs = dataSource.obtenerDato("SELECT to_char(fecha_fin_timbrado, 'DD/MM/YYYY') as datos FROM stock_facturacion.timbrados WHERE estado = 0");
            if (rs.next()) {
                htmlDatos.append(rs.getString("datos"));
            }
            break;
        case 4:
            rs = dataSource.obtenerDato("SELECT id_timbrado FROM stock_facturacion.timbrados WHERE estado = 0");
            if (rs.next()) {
                htmlDatos.append(rs.getString("id_timbrado"));
            }
            break;
        case 5:
            String retorno;
            rs = dataSource.obtenerDato("SELECT id_timbrado FROM stock_facturacion.timbrados WHERE estado = 0");
            if (rs.next()) {
                retorno = "s";
            }else{
                retorno = "n";
            }
            htmlDatos.append(retorno);
            break;
        case 6://OBTIENE ULTIMO NRO FACTURA DEL TIMBRADO
            rs = dataSource.obtenerDato("SELECT "
                    + "COALESCE(max(ultimo_nro_factura), 0) as factura "
                    + "FROM stock_facturacion.timbrados "
                    + "WHERE estado = 0");
            if (rs.next()) {
                htmlDatos.append(rs.getString("factura"));
            }
            break;
    }
    out.print(htmlDatos.toString());
    cn.desConectarBD();
%>
