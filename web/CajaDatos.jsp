 <%-- 
    Document   : CajaDatos
    Created on : 3/07/2020, 09:19:38 PM
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
    switch(Integer.parseInt(opcion)){
        case 1:
            rs = dataSource.obtenerDato("SELECT id_caja, descripcion_caja FROM stock_facturacion.cajas c "
                    + "LEFT JOIN usuarios u on u.login_usuario = c.usu_alta "
                    + "WHERE nombre_empresa = '"+nombre_empresa+"' "
                    + "ORDER BY 1 asc;");
            while(rs.next()){
                htmlDatos.append("<tr>"
                        + "<td>"+rs.getString("id_caja") +"</td>"
                        + "<td>"+rs.getString("descripcion_caja") +"</td>"
                        + "<td><img src='imagenes/edit.png' style='cursor:pointer' onclick=\"abrirFormulario('modificar', "+rs.getString("id_caja")+")\" "
                        + "data-toggle='modal' data-target='#modalForm'></td>"
                        + "<td><img src='imagenes/delete.png' style='cursor:pointer' onclick=\"abrirFormulario('eliminar', "+rs.getString("id_caja")+")\" "
                        + "data-toggle='modal' data-target='#modalForm'></td>"
                        + "</tr>");
            }
            break;
        case 2:
            rs = dataSource.obtenerDato("SELECT descripcion_caja||','||id_caja||','||nro_caja as datos FROM stock_facturacion.cajas WHERE id_caja = "+id);
            if(rs.next()){
                htmlDatos.append(rs.getString("datos"));
            }
            break;
        case 3:
            rs = dataSource.obtenerDato("SELECT "
                    + "nro_caja "
                    + "FROM stock_facturacion.ventas v  "
                    + "LEFT JOIN stock_facturacion.cajas c on c.id_caja = v.id_caja "
                    + "WHERE id_venta =  "+id);
            if(rs.next()){
                htmlDatos.append(rs.getString("nro_caja"));
            }
            break;
    }
    out.print(htmlDatos.toString());
    cn.desConectarBD();
%>

