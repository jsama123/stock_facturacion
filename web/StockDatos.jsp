<%-- 
    Document   : StockDatos
    Created on : 24/06/2020, 05:30:27 PM
    Author     : Jose Samaniego
--%>

<%@page import="java.text.DecimalFormat"%>
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
    
    DecimalFormat formatea = new DecimalFormat("###,###.##");
    
    fuenteDatos dataSource = new fuenteDatos();
    dataSource.setConexion(cn.getConexion());

    int j = 0;
    String opcion = request.getParameter("opcion");
    String id_deposito = request.getParameter("id_deposito");
    String id = request.getParameter("id_stock");
    String nombre_empresa = "";
    rs1 = dataSource.obtenerDato("SELECT nombre_empresa FROM usuarios WHERE login_usuario = '" + usuario + "'");
    if (rs1.next()) {
        nombre_empresa = rs1.getString("nombre_empresa");
    }
    switch (Integer.parseInt(opcion)) {
        case 1:
            rs = dataSource.obtenerDato("SELECT id_deposito_sucursal, deposito_sucursal_descripcion "
                    + "FROM stock_facturacion.depositos_sucursales s "
                    + "LEFT JOIN usuarios u on u.login_usuario = s.usu_alta "
                    + "WHERE nombre_empresa = '"+nombre_empresa+"'");
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("id_deposito_sucursal") + "'>" + rs.getString("deposito_sucursal_descripcion") + "</option>");
            }
            break;
        case 2:
            rs = dataSource.obtenerDato("SELECT id_stock, articulo_descripcion, existencia::int, minimo::int, maximo::int, "
                    + "costo_compra::int, costo_venta::int "
                    + "FROM stock_facturacion.stocks s "
                    + "LEFT JOIN stock_facturacion.articulo_costos ac on ac.id_articulo_costo = s.id_articulo_costo "
                    + "LEFT JOIN stock_facturacion.articulos a on a.id_articulo = s.id_articulo "
                    + "LEFT JOIN usuarios u on u.login_usuario = s.usu_alta "
                    + "WHERE s.id_deposito_sucursal = "+id_deposito+" AND nombre_empresa = '"+nombre_empresa+"' "
                    + "AND ac.id_articulo_costo IN (SELECT id_articulo_costo FROM stock_facturacion.stocks)"
                    + " ORDER BY 2 asc");
            while (rs.next()) {
                j++;
                htmlDatos.append(""
                        + "<tr>"
                        + "<td><input type='checkbox' name='chkArticulos' onclick='checkear(\"Articulos\")'  value='" + rs.getString("id_stock") + "' </td>"
                        + "<td>" + rs.getString("id_stock") + "</td>"
                        + "<td>" + rs.getString("articulo_descripcion") + "</td>"
                        + "<td><input size='7' type='text' name='numeros' value='"+rs.getString("minimo")+"' id='txtMinimo_" + j + "'></td>"
                        + "<td><input size='7' type='text' name='numeros' value='"+rs.getString("maximo")+"' id='txtMaximo_" + j + "'></td>"
                        + "<td>" + formatea.format(Double.valueOf(rs.getString("costo_compra"))) + "</td>"
                        + "<td>" + formatea.format(Double.valueOf(rs.getString("costo_venta"))) + "</td>"
                        + "</tr>");
            }
            break;
        case 3:
            rs = dataSource.obtenerDato("SELECT "
                    + "a.id_articulo, "
                    + "articulo_descripcion, "
                    + "costo_compra::int,"
                    + "costo_venta::int,"
                    + "a.id_articulo||'-'||id_articulo_costo as artCosto "
                    + "FROM stock_facturacion.articulo_costos ac "
                    + "LEFT JOIN stock_facturacion.articulos a on ac.id_articulo = a.id_articulo "
                    + "LEFT JOIN usuarios u on u.login_usuario = a.usu_alta "
                    + "WHERE a.id_articulo NOT IN( "
                    + "SELECT id_articulo FROM stock_facturacion.stocks s "
                    + "LEFT JOIN usuarios u on u.login_usuario = S.usu_alta "
                    + "WHERE id_deposito_sucursal = " + id_deposito + " AND nombre_empresa = '"+nombre_empresa+"') "
                    + "AND nombre_empresa = '"+nombre_empresa+"' OR id_articulo_costo NOT IN( "
                    + "SELECT id_articulo_costo FROM stock_facturacion.stocks s "
                    + "LEFT JOIN usuarios u on u.login_usuario = S.usu_alta "
                    + "WHERE id_deposito_sucursal = " + id_deposito + " AND nombre_empresa = '"+nombre_empresa+"')"
                    + " ORDER BY 2 asc");
            while (rs.next()) {
                j++;
                htmlDatos.append(""
                        + "<tr>"
                        + "<td><input type='checkbox' name='chkArticulos' onclick='checkear(\"Articulos\")'  value='" + rs.getString("artCosto") + "' </td>"
                        + "<td>" + rs.getString("id_articulo") + "</td>"
                        + "<td>" + rs.getString("articulo_descripcion") + "</td>"
                        + "<td><input size='7' type='text' value='1' name='numeros' id='txtMinimo_" + j + "'></td>"
                        + "<td><input size='7' type='text' value='1' name='numeros' id='txtMaximo_" + j + "'></td>"
                        + "<td>" + formatea.format(Double.valueOf(rs.getString("costo_compra"))) + "</td>"
                        + "<td>" + formatea.format(Double.valueOf(rs.getString("costo_venta"))) + "</td>"
                        + "</tr>");
            }
            break;
        case 4:
            rs = dataSource.obtenerDato("SELECT  "
                    + "id_articulo "
                    + "FROM stock_facturacion.stocks "
                    + "WHERE id_stock = "+id);
            if(rs.next()){
                htmlDatos.append(rs.getString("id_articulo"));
            }
            break;
    }
    out.print(htmlDatos.toString());
    cn.desConectarBD();
%>
