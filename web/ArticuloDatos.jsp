<%-- 
    Document   : MarcaDatos
    Created on : 3/06/2020, 10:08:25 PM
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
    fuenteDatos dataSource = new fuenteDatos();
    dataSource.setConexion(cn.getConexion());

    DecimalFormat formatea = new DecimalFormat("###,###.##");
    
    String opcion = request.getParameter("opcion");
    String id = request.getParameter("id");
    String nombre_empresa = "";
    rs1 = dataSource.obtenerDato("SELECT nombre_empresa FROM usuarios WHERE login_usuario = '" + usuario + "'");
    if (rs1.next()) {
        nombre_empresa = rs1.getString("nombre_empresa");
    }
    switch (Integer.parseInt(opcion)) {
        case 1:
            rs = dataSource.obtenerDato("SELECT id_articulo, articulo_descripcion, marca_descripcion, grupo_descripcion "
                    + "FROM stock_facturacion.articulos a  "
                    + "LEFT JOIN stock_facturacion.marcas m on m.id_marca = a.id_marca "
                    + "LEFT JOIN stock_facturacion.grupos g on g.id_grupo = a.id_grupo "
                    + "LEFT JOIN usuarios u on u.login_usuario = a.usu_alta "
                    + "WHERE nombre_empresa = '" + nombre_empresa + "' "
                    + " ORDER BY 1 asc");
            while (rs.next()) {
                htmlDatos.append("<tr>"
                        + "<td>" + rs.getString("id_articulo") + "</td>"
                        + "<td>" + rs.getString("marca_descripcion") + "</td>"
                        + "<td>" + rs.getString("grupo_descripcion") + "</td>"
                        + "<td>" + rs.getString("articulo_descripcion") + "</td>"
                        + "<td><img src='imagenes/file.png' style='cursor:pointer' data-toggle='modal' data-target='#modalImagenes' onclick=\"completar(" + rs.getString("id_articulo") + ", '" + rs.getString("articulo_descripcion") + "')\"></td>"
                        + "<td><img class='imgGrid' src='imagenes/money.png' style='cursor:pointer' onclick=\"abrirDetalleCostos('" + rs.getString("articulo_descripcion") + "', " + rs.getString("id_articulo") + ")\" "
                        + "data-toggle='modal' data-target='#modalDetalleArticulo'></td>"
                        + "<td><img class='imgGrid' src='imagenes/edit.png' style='cursor:pointer' onclick=\"abrirFormulario('modificar', " + rs.getString("id_articulo") + ")\" "
                        + "data-toggle='modal' data-target='#modalForm'></td>"
                        + "<td><img class='imgGrid' src='imagenes/delete.png' style='cursor:pointer' onclick=\"abrirFormulario('eliminar', " + rs.getString("id_articulo") + ")\" "
                        + "data-toggle='modal' data-target='#modalForm'></td>"
                        + "</tr>");
            }
            break;
        case 2:
            rs = dataSource.obtenerDato("SELECT id_marca, marca_descripcion "
                    + "FROM stock_facturacion.marcas a "
                    + "LEFT JOIN usuarios u on u.login_usuario = a.usu_alta "
                    + "WHERE nombre_empresa = '" + nombre_empresa + "' ");
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("id_marca") + "'>" + rs.getString("marca_descripcion") + "</option>");
            }
            break;
        case 3:
            rs = dataSource.obtenerDato("SELECT id_grupo, grupo_descripcion "
                    + "FROM stock_facturacion.grupos a "
                    + "LEFT JOIN usuarios u on u.login_usuario = a.usu_alta "
                    + "WHERE nombre_empresa = '" + nombre_empresa + "' ");
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("id_grupo") + "'>" + rs.getString("grupo_descripcion") + "</option>");
            }
            break;
        case 4:
            rs = dataSource.obtenerDato("SELECT id_medida, medida_descripcion "
                    + "FROM stock_facturacion.medidas a "
                    + "LEFT JOIN usuarios u on u.login_usuario = a.usu_alta "
                    + "WHERE nombre_empresa = '" + nombre_empresa + "' ");
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("id_medida") + "'>" + rs.getString("medida_descripcion") + "</option>");
            }
            break;
        case 5:
            rs = dataSource.obtenerDato("SELECT id_marca||','||id_medida||','||id_grupo||','||codigo_barra||','||articulo_descripcion||','||to_char(fecha_vencimiento, 'DD/MM/YYYY')"
                    + "||','||COALESCE(costo_articulo::int, 0)||','||id_impuesto||','||COALESCE(precio_venta::int, 0) as datos "
                    + "FROM stock_facturacion.articulos "
                    + "WHERE id_articulo = " + id);
            if (rs.next()) {
                htmlDatos.append(rs.getString("datos"));
            }
            break;
        case 6:
            rs = dataSource.obtenerDato("SELECT id_impuesto, descripcion_impuesto "
                    + "FROM stock_facturacion.impuestos a ");
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("id_impuesto") + "'>" + rs.getString("descripcion_impuesto") + "</option>");
            }
            break;
        case 7:
            rs = dataSource.obtenerDato("SELECT id_articulo_costo, costo_compra::int, costo_venta::int "
                    + "FROM stock_facturacion.articulo_costos WHERE id_articulo = "+id);
            while(rs.next()){
                htmlDatos.append("<tr>"
                        + "<td>" + formatea.format(Double.valueOf(rs.getString("costo_compra"))) + "</td>"
                        + "<td>" + formatea.format(Double.valueOf(rs.getString("costo_venta"))) + "</td>"
                        + "<td><img class='imgGrid' src='imagenes/edit.png' style='cursor:pointer' onclick=\"rellenarCamposCostos(" + rs.getString("costo_compra") + ", " + rs.getString("id_articulo_costo") + ", " + rs.getString("costo_venta") + ")\"></td>"
                        + "<td><img class='imgGrid' src='imagenes/delete.png' style='cursor:pointer' onclick=\"accionProcesoDetalleArticulo(3, " + rs.getString("id_articulo_costo") + ")\"></td>"
                        + "</tr>");
            }
            break;
    }
    out.print(htmlDatos.toString());
    cn.desConectarBD();
%>
