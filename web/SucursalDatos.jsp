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
            rs = dataSource.obtenerDato("SELECT id_sucursal, descripcion_sucursal, direccion_sucursal FROM stock_facturacion.sucursales a "
                    + "LEFT JOIN usuarios u on u.login_usuario = a.usu_alta "
                    + "WHERE nombre_empresa = '"+nombre_empresa+"' "
                    + "ORDER BY 1 asc;");
            while(rs.next()){
                htmlDatos.append("<tr>"
                        + "<td>"+rs.getString("id_sucursal") +"</td>"
                        + "<td>"+rs.getString("descripcion_sucursal") +"</td>"
                        + "<td>"+rs.getString("direccion_sucursal") +"</td>"
                        + "<td><img src='imagenes/edit.png' style='cursor:pointer' onclick=\"abrirFormulario('modificar', "+rs.getString("id_sucursal")+")\" "
                        + "data-toggle='modal' data-target='#modalForm'></td>"
                        + "<td><img src='imagenes/delete.png' style='cursor:pointer' onclick=\"abrirFormulario('eliminar', "+rs.getString("id_sucursal")+")\" "
                        + "data-toggle='modal' data-target='#modalForm'></td>"
                        + "</tr>");
            }
            break;
        case 2:
            rs = dataSource.obtenerDato("SELECT id_sucursal||'-'||descripcion_sucursal||'-'||direccion_sucursal||'-'||"
                    + "telefono_sucursal||'-'||nro_sucursal as datos FROM stock_facturacion.sucursales WHERE id_sucursal = "+id);
            if(rs.next()){
                htmlDatos.append(rs.getString("datos"));
            }
            break;
        case 3:
            rs = dataSource.obtenerDato("SELECT nro_sucursal as datos FROM stock_facturacion.sucursales WHERE sucursal_activa = 0");
            if(rs.next()){
                htmlDatos.append(rs.getString("datos"));
            }
            break;
    }
    out.print(htmlDatos.toString());
    cn.desConectarBD();
%>
