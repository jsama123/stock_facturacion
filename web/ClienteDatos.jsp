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
    switch(Integer.parseInt(opcion)){
        case 1:
            rs = dataSource.obtenerDato("SELECT id_cliente, ci_ruc_cliente, razon_social_cliente FROM stock_facturacion.clientes c "
                    + "LEFT JOIN usuarios u on u.login_usuario = c.usu_alta "
                    + "WHERE nombre_empresa = '"+nombre_empresa+"' "
                    + "ORDER BY 1 asc;");
            while(rs.next()){
                htmlDatos.append("<tr>"
                        + "<td>"+rs.getString("id_cliente") +"</td>"
                        + "<td>"+rs.getString("ci_ruc_cliente") +"</td>"
                        + "<td>"+rs.getString("razon_social_cliente") +"</td>"
                        + "<td><img src='imagenes/edit.png' style='cursor:pointer' onclick=\"abrirFormulario('modificar', "+rs.getString("id_cliente")+")\" "
                        + "data-toggle='modal' data-target='#modalForm'></td>"
                        + "<td><img src='imagenes/delete.png' style='cursor:pointer' onclick=\"abrirFormulario('eliminar', "+rs.getString("id_cliente")+")\" "
                        + "data-toggle='modal' data-target='#modalForm'></td>"
                        + "</tr>");
            }
            break;
        case 2:
            rs = dataSource.obtenerDato("SELECT id_cliente||','||ci_ruc_cliente||','||razon_social_cliente||','||nro_telefono_cliente||','||direccion_cliente"
                    + "||','||email_cliente as datos FROM stock_facturacion.clientes WHERE id_cliente = "+id);
            if(rs.next()){
                htmlDatos.append(rs.getString("datos"));
            }
            break;
        case 3:
            rs = dataSource.obtenerDato("SELECT  "
                    + "id_cliente "
                    + "FROM stock_facturacion.clientes "
                    + "WHERE razon_social_cliente = 'SIN NOMBRE'");
            if(rs.next()){
                htmlDatos.append(rs.getString("id_cliente"));
            }
            break;
    }
    out.print(htmlDatos.toString());
    cn.desConectarBD();
%>
