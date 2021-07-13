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
    int j = 0;
    switch(Integer.parseInt(opcion)){
        case 1:
            rs = dataSource.obtenerDato("SELECT id_articulo, articulo_descripcion "
                    + "FROM stock_facturacion.articulos a  "
                    + "LEFT JOIN usuarios u on u.login_usuario = a.usu_alta "
                    + "WHERE nombre_empresa = '"+nombre_empresa+"' "
                    + "ORDER BY 2 asc");
            while(rs.next()){
                j++;
                htmlDatos.append("<tr>"
                        + "<td><input type=\"checkbox\" name=\"chkArticulos\" value=\"" + rs.getString("id_articulo") + "\"/></td>"
                        + "<td>"+ j +"</td>"
                        + "<td>"+rs.getString("id_articulo") +"</td>"
                        + "<td>"+rs.getString("articulo_descripcion") +"</td>"
                        + "<td><input type='text' value='1' maxlength='2' size='3'"
                        + "id=\"txtCantidadImpresion_" + j + "\" name=\"txtCantidadImpresion_" + j + "\" "
                        + "onchange='return soloNumeros(30, \"txtCantidadImpresion_" + j + "\")' title=\"Rango[1 a 30]\"></td>"
                        + "</tr>");
            }
            break;
    }
    out.print(htmlDatos.toString());
    cn.desConectarBD();
%>
